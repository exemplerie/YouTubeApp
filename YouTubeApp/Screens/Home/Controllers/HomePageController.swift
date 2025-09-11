import UIKit


class HomePageController: UIViewController {
    
    private lazy var filtersBar: FiltersBar = {
        let bar = FiltersBar(
            frame: CGRect(x: 0, y: 0, width: view.frame.width, height: Design.HomePage.filtersBarHeight)
        )
        bar.onFilterSelected = { [weak self] filter in
            self?.filterVideos(by: filter)
        }
        return bar
    }()
    
    private let fullLengthVideoService = FullLengthVideoService()
    private let shortsVideoService = ShortsVideoService()
    
    private var fullLengthVideos: [FullLengthVideo] = []
    private var shortsVideos: [ShortsVideo] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Design.HomePage.backgroundColor
        cv.delegate = self
        cv.dataSource = self
        
        cv.register(FullLengthVideoCell.self, forCellWithReuseIdentifier: FullLengthVideoCell.identifier)
        cv.register(ShortsCollectionCell.self, forCellWithReuseIdentifier: ShortsCollectionCell.identifier)
        cv.register(ShortsSectionCell.self, forCellWithReuseIdentifier: ShortsSectionCell.identifier)
        cv.register(FiltersBarReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: FiltersBarReusableView.identifier)
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Design.HomePage.backgroundColor
        
        setupNavBar()
        setupCollectionView()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutCollectionView()
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear

        let separator = UIView(frame: CGRect(
            x: 16,
            y: 44,
            width: view.frame.width - 32,
            height: 1
        ))
        separator.backgroundColor = Design.VideoTable.Color.borderColor
        navigationController?.navigationBar.addSubview(separator)

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        let logo = UIImageView(image: UIImage(named: Design.NavBar.youtubeLogoName))
        logo.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logo)

        let tvCastButton = makeNavBarButton(imageName: Design.NavBar.tvCastIconName, action: #selector(tvCastButtonTapped))
        let notificationsButton = makeNavBarButton(imageName: Design.NavBar.notificationsIconName, action: #selector(notificationsButtonTapped))
        let searchButton = makeNavBarButton(imageName: Design.NavBar.searchIconName, action: #selector(searchButtonTapped))
        let profileButton = makeProfileButton(imageName: Design.NavBar.userProfileIconName, action: #selector(userProfileButtonTapped))

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: profileButton),
            UIBarButtonItem(customView: searchButton),
            UIBarButtonItem(customView: notificationsButton),
            UIBarButtonItem(customView: tvCastButton)
        ]
    }
    
    private func makeNavBarButton(imageName: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: Design.NavBar.buttonSize, height: Design.NavBar.buttonSize)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    private func makeProfileButton(imageName: String, action: Selector) -> UIView {
        let buttonSize = Design.NavBar.buttonSize

        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        button.layer.cornerRadius = buttonSize / 2
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)

        let container = UIView(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
        container.addSubview(button)
        return container
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
    }
    
    private func layoutCollectionView() {
        collectionView.frame = view.bounds
    }
    
    private func loadData() {
        fullLengthVideos = fullLengthVideoService.getAllFullLengthVideos()
        shortsVideos = shortsVideoService.getShortsVideos()
    }
    
    private func filterVideos(by category: VideoCategory?) {
        fullLengthVideos = category != nil
        ? fullLengthVideoService.getFullLengthVideosByCategory(category!)
        : fullLengthVideoService.getAllFullLengthVideos()
        
        collectionView.reloadData()
    }
    
    @objc private func tvCastButtonTapped() {
        print("Stream content on a device")
    }
    
    @objc private func notificationsButtonTapped() {
        print("Show notifications")
    }
    
    @objc private func searchButtonTapped() {
        print("Open search")
    }
    
    @objc private func userProfileButtonTapped() {
        print("Open profile")
    }
}


extension HomePageController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            switch sectionIndex {
            case Design.CollectionSectionsIndex.fullLengthFirst: return self.createFirstVideoSection()
            case Design.CollectionSectionsIndex.shorts: return self.createShortsSection()
            default: return self.createAdditionalVideosSection()
            }
        }
    }
    
    private func createFirstVideoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Design.HomePage.filtersBarHeight)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createShortsSection() -> NSCollectionLayoutSection {
        let height = Design.ShortsTable.stripHeight * 2 +
                     Design.ShortsTable.headerHeight +
                     Design.ShortsTable.collectionViewTopPadding +
                     Design.ShortsTable.collectionViewHeight +
                     Design.ShortsTable.collectionViewBottomPadding
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
    
    private func createAdditionalVideosSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
}


extension HomePageController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Design.CollectionSectionsIndex.fullLengthFirst: return fullLengthVideos.isEmpty ? 0 : 1
        case Design.CollectionSectionsIndex.shorts: return shortsVideos.isEmpty ? 0 : 1
        default: return max(fullLengthVideos.count - 1, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Design.CollectionSectionsIndex.fullLengthFirst:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FullLengthVideoCell.identifier,
                for: indexPath
            ) as! FullLengthVideoCell
            cell.configure(with: fullLengthVideos[0])
            return cell
        case Design.CollectionSectionsIndex.shorts:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShortsSectionCell.identifier,
                for: indexPath
            ) as! ShortsSectionCell
            cell.configure(with: shortsVideos)
            cell.onShortSelected = { [weak self] _, idx in
                guard let self else { return }
                let shortsVC = ShortsFeedController(shorts: shortsVideos, startIndex: idx)
                navigationController?.pushViewController(shortsVC, animated: true)
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FullLengthVideoCell.identifier,
                for: indexPath
            ) as! FullLengthVideoCell
            cell.configure(with: fullLengthVideos[indexPath.item + 1])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, indexPath.section == 0 else {
            return UICollectionReusableView()
        }
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FiltersBarReusableView.identifier,
            for: indexPath
        ) as! FiltersBarReusableView
        header.configure(with: filtersBar)
        return header
    }
}

extension HomePageController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        let shortsVC = ShortsFeedController(shorts: shortsVideos, startIndex: indexPath.item)
        navigationController?.pushViewController(shortsVC, animated: true)
    }
}

class FiltersBarReusableView: UICollectionReusableView {
    static let identifier = "FiltersBarReusableView"
    
    private var filtersBar: FiltersBar?
    
    func configure(with bar: FiltersBar) {
        filtersBar = bar
        addSubview(bar)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        filtersBar?.frame = bounds
    }
}
