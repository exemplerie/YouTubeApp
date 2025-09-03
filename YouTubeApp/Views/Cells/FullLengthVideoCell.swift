import UIKit

class FullLengthVideoCell: UITableViewCell {
    static let identifier = "fullLengthVideoCell"
    
    let videoName = TopAlignedLabel()
    let previewImage = UIImageView()
    let avatarImage = UIImageView()
    let uploadDate = UILabel()
    let viewsCount = UILabel()
    let videoSettingsButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        previewImage.contentMode = .scaleAspectFill
        previewImage.clipsToBounds = true
        contentView.addSubview(previewImage)
        
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.clipsToBounds = true
        avatarImage.layer.masksToBounds = true
        contentView.addSubview(avatarImage)
        
        videoName.font = FontBuilder.customFont(.videoPreviewTitle)
        videoName.numberOfLines = 0
        videoName.lineBreakMode = .byClipping
        contentView.addSubview(videoName)
        
        viewsCount.font = FontBuilder.customFont(.videoExtraInfo)
        viewsCount.textColor = Design.VideoTable.Color.dataTextColor
        contentView.addSubview(viewsCount)
        
        uploadDate.font = FontBuilder.customFont(.videoExtraInfo)
        uploadDate.textColor = Design.VideoTable.Color.dataTextColor
        contentView.addSubview(uploadDate)
        
        contentView.addSubview(videoSettingsButton)
    }
    
    func configure(with video: FullLengthVideo) {
        videoName.text = video.name
        previewImage.image = UIImage(named: video.image)
        avatarImage.image = UIImage(named: video.chanel.avatarImage)
        uploadDate.text = video.uploadedAt.formattedWithDots()
        viewsCount.text = "\(video.views.formattedWithCommas) views"
        videoSettingsButton.setImage(UIImage(named: Design.FullLengthVideoCell.settingsIconName), for: .normal)
        videoSettingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentWidth = contentView.bounds.width
        
        previewImage.frame = CGRect(
            x: 0,
            y: 0,
            width: contentWidth,
            height: Design.FullLengthVideoCell.previewHeight
        )
        
        avatarImage.frame = CGRect(
            x: Design.FullLengthVideoCell.padding,
            y: previewImage.frame.maxY + Design.FullLengthVideoCell.padding,
            width: Design.FullLengthVideoCell.avatarSize,
            height: Design.FullLengthVideoCell.avatarSize
        )
        avatarImage.layer.cornerRadius = Design.FullLengthVideoCell.avatarSize / 2
        
        let labelWidth = contentWidth - avatarImage.frame.maxX - Design.FullLengthVideoCell.labelRightMargin
        let textHeight = videoName.text?.heightForWidth(labelWidth, font: FontBuilder.customFont(.videoPreviewTitle)) ?? 0
        videoName.frame = CGRect(
            x: avatarImage.frame.maxX + Design.FullLengthVideoCell.padding,
            y: avatarImage.frame.minY,
            width: labelWidth,
            height: textHeight
        )
        
        viewsCount.sizeToFit()
        viewsCount.frame = CGRect(
            x: videoName.frame.minX,
            y: videoName.frame.maxY + Design.FullLengthVideoCell.viewsTopMargin,
            width: viewsCount.frame.width,
            height: Design.FullLengthVideoCell.infoLabelHeight
        )
        
        uploadDate.sizeToFit()
        uploadDate.frame = CGRect(
            x: viewsCount.frame.maxX + Design.FullLengthVideoCell.infoLabelSpacing,
            y: viewsCount.frame.minY,
            width: uploadDate.frame.width,
            height: Design.FullLengthVideoCell.infoLabelHeight
        )
        
        videoSettingsButton.frame = CGRect(
            x: contentWidth - Design.FullLengthVideoCell.settingsButtonRightMargin,
            y: videoName.frame.minY,
            width: Design.FullLengthVideoCell.settingsButtonSize,
            height: Design.FullLengthVideoCell.settingsButtonSize
        )
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let contentWidth = size.width
        let textHeight = videoName.text?.heightForWidth(
            contentWidth - Design.FullLengthVideoCell.avatarSize - Design.FullLengthVideoCell.labelRightMargin,
            font: FontBuilder.customFont(.videoPreviewTitle)
        ) ?? 0
        
        let totalHeight = Design.FullLengthVideoCell.previewHeight +
            Design.FullLengthVideoCell.padding +
            textHeight +
            Design.FullLengthVideoCell.viewsTopMargin +
            Design.FullLengthVideoCell.infoLabelHeight +
            Design.FullLengthVideoCell.settingsButtonBottomMargin
        
        return CGSize(width: size.width, height: totalHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoName.text = nil
        previewImage.image = nil
        avatarImage.image = nil
        viewsCount.text = nil
        uploadDate.text = nil
    }
    
    @objc private func settingsButtonTapped() {
        print("Video settings")
    }
}

class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: textRect.size.height))
    }
}
