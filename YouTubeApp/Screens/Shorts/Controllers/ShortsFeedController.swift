import UIKit

class ShortsFeedController: UIViewController {
    
    private let shortsVideos: [ShortsVideo]
    private let startIndex: Int
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Design.ShortsFeed.collectionViewLineSpacing
        layout.itemSize = view.bounds.size
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = Design.ShortsFeed.collectionViewIsPagingEnabled
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(ShortsPlayerCell.self, forCellWithReuseIdentifier: ShortsPlayerCell.identifier)
        return cv
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Design.ShortsFeed.backButtonImageName), for: .normal)
        button.tintColor = Design.ShortsFeed.backButtonTintColor
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(shorts: [ShortsVideo], startIndex: Int) {
        self.shortsVideos = shorts
        self.startIndex = startIndex
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Design.ShortsFeed.backgroundColor
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupCollectionView()
        setupBackButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        backButton.frame = CGRect(
            x: Design.ShortsFeed.backButtonLeftPadding,
            y: view.safeAreaInsets.top + Design.ShortsFeed.backButtonTopPadding,
            width: Design.ShortsFeed.backButtonSize,
            height: Design.ShortsFeed.backButtonSize
        )
        scrollToStartIndex()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        view.bringSubviewToFront(backButton)
    }
    
    private func scrollToStartIndex() {
        guard startIndex < shortsVideos.count else { return }
        let indexPath = IndexPath(item: startIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
    }
    
    @objc private func backButtonTapped() {
        if let navController = navigationController, navController.viewControllers.count > 1 {
            navController.popViewController(animated: true)
        } else {
            tabBarController?.selectedIndex = 0
        }
    }
}

extension ShortsFeedController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shortsVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortsPlayerCell.identifier, for: indexPath) as! ShortsPlayerCell
        cell.configure(with: shortsVideos[indexPath.item])
        return cell
    }
}
