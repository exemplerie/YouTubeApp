import UIKit


class HomePageController: UIViewController {
    
    private let videoTableView = UITableView(frame: .zero, style: .grouped)
    private let customNavBar = CustomNavBarViewController()
    private lazy var filtersBar: FiltersBar = {
        let bar = FiltersBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: Design.HomePage.filtersBarHeight))
        bar.onFilterSelected = { [weak self] filter in
            self?.filterVideos(by: filter)
        }
        return bar
    }()
    
    private let fullLengthVideoService = FullLengthVideoService()
    private let shortsVideoService = ShortsVideoService()
    
    private var fullLengthVideos: [FullLengthVideo] = []
    private var shortsVideos: [ShortsVideo] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Design.HomePage.backgroundColor
        
        setupNavBar()
        setupTableView()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutNavBar()
        layoutTableView()
    }
    
    private func setupNavBar() {
        addChild(customNavBar)
        view.addSubview(customNavBar.view)
        customNavBar.didMove(toParent: self)
    }
    
    private func setupTableView() {
        videoTableView.register(FullLengthVideoCell.self, forCellReuseIdentifier: FullLengthVideoCell.identifier)
        videoTableView.register(ShortsTableCell.self, forCellReuseIdentifier: ShortsTableCell.identifier)
        
        videoTableView.dataSource = self
        videoTableView.delegate = self
        videoTableView.estimatedRowHeight = Design.HomePage.estimatedRowHeight
        
        view.addSubview(videoTableView)
    }
    
    private func layoutNavBar() {
        customNavBar.view.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.width,
            height: Design.HomePage.navBarHeight
        )
    }
    
    private func layoutTableView() {
        let topInset = view.safeAreaInsets.top + Design.HomePage.navBarHeight
        videoTableView.frame = CGRect(
            x: 0,
            y: topInset,
            width: view.frame.width,
            height: view.frame.height - topInset
        )
    }
    
    private func loadData() {
        fullLengthVideos = fullLengthVideoService.getAllFullLengthVideos()
        shortsVideos = shortsVideoService.getShortsVideos()
    }
    
    private func filterVideos(by category: VideoCategory?) {
        fullLengthVideos = category != nil
        ? fullLengthVideoService.getFullLengthVideosByCategory(category!)
        : fullLengthVideoService.getAllFullLengthVideos()
        
        videoTableView.reloadData()
    }
}

extension HomePageController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullLengthVideos.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == Design.HomePage.shortsRowIndex {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShortsTableCell.identifier, for: indexPath) as! ShortsTableCell
            cell.configure(with: shortsVideos)
            cell.onShortSelected = { [weak self] _, index in
                let shortsVC = ShortsFeedController(
                    shorts: self?.shortsVideos ?? [],
                    startIndex: index
                )
                self?.navigationController?.pushViewController(shortsVC, animated: true)
            }
            return cell
        } else {
            let videoIndex = indexPath.row > Design.HomePage.shortsRowIndex ? indexPath.row - 1 : indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: FullLengthVideoCell.identifier, for: indexPath) as! FullLengthVideoCell
            if fullLengthVideos.indices.contains(videoIndex) {
                cell.configure(with: fullLengthVideos[videoIndex])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == Design.HomePage.shortsRowIndex { return Design.HomePage.shortsRowHeight }
        
        let videoIndex = indexPath.row > Design.HomePage.shortsRowIndex ? indexPath.row - 1 : indexPath.row
        guard fullLengthVideos.indices.contains(videoIndex) else { return Design.HomePage.fullLengthRowDefaultHeight }
        
        let cell = FullLengthVideoCell()
        cell.configure(with: fullLengthVideos[videoIndex])
        return cell.sizeThatFits(CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude)).height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == Design.HomePage.shortsRowIndex ? Design.HomePage.shortsRowHeight : Design.HomePage.fullLengthRowDefaultHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return filtersBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Design.HomePage.filtersBarHeight
    }
}
