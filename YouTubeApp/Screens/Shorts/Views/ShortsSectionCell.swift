import UIKit

class ShortsSectionCell: UICollectionViewCell {
    static let identifier = "ShortsSectionCell"
    
    private var shortsVideos: [ShortsVideo] = []
    var onShortSelected: ((ShortsVideo, Int) -> Void)?
    
    private let topStrip = UIView()
    private let bottomStrip = UIView()
    private let headerView = UIView()
    private let shortsIcon = UIImageView()
    private let shortsLabel = UILabel()
    private let shortsLabelBeta = UILabel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Design.ShortsTable.collectionViewSpacing
        layout.itemSize = Design.ShortsTable.collectionViewItemSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ShortsCollectionCell.self, forCellWithReuseIdentifier: ShortsCollectionCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStrips()
        setupHeader()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStrips() {
        topStrip.backgroundColor = Design.VideoTable.Color.filterButtonsColor
        bottomStrip.backgroundColor = Design.VideoTable.Color.filterButtonsColor
        contentView.addSubview(topStrip)
        contentView.addSubview(bottomStrip)
    }
    
    private func setupHeader() {
        headerView.backgroundColor = .white
        shortsIcon.image = UIImage(named: "shortsBannerImage")
        shortsIcon.contentMode = .scaleAspectFit
        
        shortsLabel.text = "Shorts"
        shortsLabel.font = FontBuilder.customFont(.shortsBannerTitle)
        shortsLabel.textColor = .black
        shortsLabel.textAlignment = .center
        
        shortsLabelBeta.text = "BETA"
        shortsLabelBeta.font = FontBuilder.customFont(.shortsBannerTitleBeta)
        shortsLabelBeta.textColor = Design.VideoTable.Color.shortsTitleBetaColor
        
        [shortsIcon, shortsLabel, shortsLabelBeta].forEach { headerView.addSubview($0) }
        contentView.addSubview(headerView)
    }
    
    private func setupCollectionView() {
        contentView.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topStrip.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: Design.ShortsTable.stripHeight)
        
        headerView.frame = CGRect(x: 0, y: topStrip.frame.maxY, width: contentView.frame.width, height: Design.ShortsTable.headerHeight)
        shortsIcon.frame = CGRect(
            x: Design.ShortsTable.iconLeftPadding,
            y: Design.ShortsTable.iconTopPadding,
            width: Design.ShortsTable.iconWidth,
            height: Design.ShortsTable.iconHeight
        )
        shortsLabel.frame = CGRect(
            x: shortsIcon.frame.maxX + Design.ShortsTable.labelSpacing,
            y: shortsIcon.frame.minY,
            width: Design.ShortsTable.labelWidth,
            height: shortsIcon.frame.height
        )
        shortsLabelBeta.frame = CGRect(
            x: shortsLabel.frame.maxX + Design.ShortsTable.betaLabelSpacing,
            y: shortsLabel.frame.minY,
            width: Design.ShortsTable.betaLabelWidth,
            height: Design.ShortsTable.betaLabelHeight
        )
        
        collectionView.frame = CGRect(
            x: Design.ShortsTable.collectionViewHorizontalPadding,
            y: headerView.frame.maxY + Design.ShortsTable.collectionViewTopPadding,
            width: contentView.frame.width,
            height: Design.ShortsTable.collectionViewHeight
        )
        
        bottomStrip.frame = CGRect(
            x: 0,
            y: contentView.frame.height - Design.ShortsTable.stripHeight,
            width: contentView.frame.width,
            height: Design.ShortsTable.stripHeight
        )
    }
    
    func configure(with shorts: [ShortsVideo]) {
        self.shortsVideos = shorts
        collectionView.reloadData()
    }
}

extension ShortsSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shortsVideos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortsCollectionCell.identifier, for: indexPath) as! ShortsCollectionCell
        cell.configure(with: shortsVideos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onShortSelected?(shortsVideos[indexPath.item], indexPath.item)
    }
}
