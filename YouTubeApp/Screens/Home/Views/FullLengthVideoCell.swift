import UIKit

class FullLengthVideoCell: UICollectionViewCell {
    static let identifier = "fullLengthVideoCell"
    
    private let previewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = Design.FullLengthVideoCell.previewPlaceholderColor
        return imageView
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = Design.FullLengthVideoCell.avatarPlaceholderColor
        return imageView
    }()
    
    private let videoName: TopAlignedLabel = {
        let label = TopAlignedLabel()
        label.font = FontBuilder.customFont(.videoPreviewTitle)
        label.numberOfLines = 2
        label.textColor = Design.FullLengthVideoCell.titleTextColor
        return label
    }()
    
    private let viewsCount: UILabel = {
        let label = UILabel()
        label.font = FontBuilder.customFont(.videoExtraInfo)
        label.textColor = Design.FullLengthVideoCell.dataTextColor
        return label
    }()
    
    private let uploadDate: UILabel = {
        let label = UILabel()
        label.font = FontBuilder.customFont(.videoExtraInfo)
        label.textColor = Design.FullLengthVideoCell.dataTextColor
        return label
    }()
    
    private let videoSettingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = Design.FullLengthVideoCell.settingsButtonTintColor
        return button
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Design.FullLengthVideoCell.infoLabelSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    var onSettingsTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .clear
        
        [previewImage, avatarImage, videoName, infoStackView, videoSettingsButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        infoStackView.addArrangedSubview(viewsCount)
        infoStackView.addArrangedSubview(uploadDate)
        
        videoSettingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        videoName.setContentCompressionResistancePriority(.required, for: .vertical)
        videoName.setContentHuggingPriority(.required, for: .vertical)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            previewImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            previewImage.heightAnchor.constraint(equalToConstant: Design.FullLengthVideoCell.previewHeight),
            
            avatarImage.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: Design.FullLengthVideoCell.padding),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Design.FullLengthVideoCell.padding),
            avatarImage.widthAnchor.constraint(equalToConstant: Design.FullLengthVideoCell.avatarSize),
            avatarImage.heightAnchor.constraint(equalToConstant: Design.FullLengthVideoCell.avatarSize),
            
            videoName.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            videoName.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: Design.FullLengthVideoCell.padding),
            videoName.trailingAnchor.constraint(equalTo: videoSettingsButton.leadingAnchor, constant: -Design.FullLengthVideoCell.padding),
            
            infoStackView.topAnchor.constraint(equalTo: videoName.bottomAnchor, constant: Design.FullLengthVideoCell.viewsTopMargin),
            infoStackView.leadingAnchor.constraint(equalTo: videoName.leadingAnchor),
            infoStackView.trailingAnchor.constraint(lessThanOrEqualTo: videoName.trailingAnchor),
            infoStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Design.FullLengthVideoCell.padding),
            
            videoSettingsButton.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            videoSettingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Design.FullLengthVideoCell.settingsButtonRightMargin),
            videoSettingsButton.widthAnchor.constraint(equalToConstant: Design.FullLengthVideoCell.settingsButtonSize),
            videoSettingsButton.heightAnchor.constraint(equalToConstant: Design.FullLengthVideoCell.settingsButtonSize)
        ])
    }
    
    func configure(with video: FullLengthVideo) {
        videoName.text = video.name
        previewImage.image = UIImage(named: video.image)
        avatarImage.image = UIImage(named: video.chanel.avatarImage)
        uploadDate.text = video.uploadedAt.formattedWithDots()
        viewsCount.text = "\(video.views.formattedWithCommas) views"
        videoSettingsButton.setImage(UIImage(named: Design.FullLengthVideoCell.settingsIconName), for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = Design.FullLengthVideoCell.avatarSize / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoName.text = nil
        previewImage.image = nil
        avatarImage.image = nil
        viewsCount.text = nil
        uploadDate.text = nil
        onSettingsTapped = nil
    }
    
    @objc private func settingsButtonTapped() {
        onSettingsTapped?()
        print("Video settings")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        contentView.frame = CGRect(x: 0, y: 0, width: targetSize.width, height: .greatestFiniteMagnitude)
        contentView.layoutIfNeeded()
        
        let bottomView = infoStackView
        let height = bottomView.frame.maxY + 20
        
        return CGSize(width: targetSize.width, height: height)
    }
}

class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: textRect.size.height))
    }
}
