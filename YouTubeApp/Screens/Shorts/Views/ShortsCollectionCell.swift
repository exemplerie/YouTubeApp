import UIKit

class ShortsCollectionCell: UICollectionViewCell {
    static let identifier = "ShortsCollectionCell"
    
    private let imageView = UIImageView()
    private let videoTitleLabel = UILabel()
    private let videoViewsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        videoTitleLabel.font = FontBuilder.customFont(.shortsPreviewTitle)
        videoTitleLabel.textColor = .white
        videoTitleLabel.numberOfLines = 3
        contentView.addSubview(videoTitleLabel)
        
        videoViewsLabel.font = FontBuilder.customFont(.shortsPreviewTitleExtraInfo)
        videoViewsLabel.textColor = .white
        contentView.addSubview(videoViewsLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        
        let titleWidth = contentView.frame.width - 2 * Design.ShortsCell.titleHorizontalPadding
        let titleY = contentView.frame.height - Design.ShortsCell.titleBottomOffset - Design.ShortsCell.titleHeight - Design.ShortsCell.viewsLabelHeight - Design.ShortsCell.viewsLabelSpacing
        
        videoTitleLabel.frame = CGRect(
            x: Design.ShortsCell.titleHorizontalPadding,
            y: titleY,
            width: titleWidth,
            height: Design.ShortsCell.titleHeight
        )
        
        let availableSpace = contentView.frame.height - videoTitleLabel.frame.maxY - Design.ShortsCell.viewsLabelBottomPadding
        videoViewsLabel.frame = CGRect(
            x: Design.ShortsCell.titleHorizontalPadding,
            y: videoTitleLabel.frame.maxY + (availableSpace - Design.ShortsCell.viewsLabelHeight) / 2,
            width: titleWidth,
            height: Design.ShortsCell.viewsLabelHeight
        )
    }
    
    func configure(with shorts: ShortsVideo) {
        imageView.image = UIImage(named: shorts.image)
        videoTitleLabel.text = shorts.name
        videoViewsLabel.text = "\(shorts.views.toShortString()) views"
    }
}
