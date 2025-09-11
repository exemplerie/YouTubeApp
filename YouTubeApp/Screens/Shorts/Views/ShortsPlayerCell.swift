import UIKit

class ShortsPlayerCell: UICollectionViewCell {
    static let identifier = "ShortsPlayerCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    private let moreButton = UIButton()
    private let likeButton = UIButton()
    private let likesCountLabel = UILabel()
    private let dislikeButton = UIButton()
    private let dislikesCountLabel = UILabel()
    private let commentButton = UIButton()
    private let commentsCountLabel = UILabel()
    private let shareButton = UIButton()
    private let shareLabel = UILabel()
    private let audioIcon = UIImageView()
    
    private let avatarImageView = UIImageView()
    private let authorNameLabel = UILabel()
    private let subscribeButton = UIButton()
    private let authorContainer = UIView()
    
    private var rightPanelItems: [(button: UIButton, label: UILabel?)] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = Design.ShortsPlayer.backgroundColor
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupImageView()
        setupTitleLabel()
        setupRightPanel()
        setupBottomPanel()
        setupButtonActions()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    private func setupTitleLabel() {
        titleLabel.textColor = Design.ShortsPlayer.titleColor
        titleLabel.font = FontBuilder.customFont(.shortsTitle)
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
    }
    
    private func setupRightPanel() {
        configureButton(moreButton, imageName: Design.ShortsPlayer.moreButtonImage)
        configureButton(likeButton, imageName: Design.ShortsPlayer.likeButtonImage)
        configureButton(dislikeButton, imageName: Design.ShortsPlayer.dislikeButtonImage)
        configureButton(commentButton, imageName: Design.ShortsPlayer.commentButtonImage)
        configureButton(shareButton, imageName: Design.ShortsPlayer.shareButtonImage)
        
        configureButtonLabel(likesCountLabel, text: "0")
        configureButtonLabel(dislikesCountLabel, text: "Dislike")
        configureButtonLabel(commentsCountLabel, text: "0")
        configureButtonLabel(shareLabel, text: "Share")
        
        audioIcon.image = UIImage(named: Design.ShortsPlayer.audioIconImage)
        audioIcon.tintColor = .white
        audioIcon.contentMode = .scaleAspectFit
        
        rightPanelItems = [
            (moreButton, nil),
            (likeButton, likesCountLabel),
            (dislikeButton, dislikesCountLabel),
            (commentButton, commentsCountLabel),
            (shareButton, shareLabel)
        ]
        
        [moreButton, likeButton, likesCountLabel, dislikeButton, dislikesCountLabel,
         commentButton, commentsCountLabel, shareButton, shareLabel, audioIcon].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupBottomPanel() {
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = Design.ShortsPlayer.avatarSize / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = Design.ShortsPlayer.avatarBorderColor.cgColor
        
        authorNameLabel.textColor = Design.ShortsPlayer.authorNameColor
        authorNameLabel.font = FontBuilder.customFont(.shortsChanelTitle)
        authorNameLabel.textAlignment = .left
        
        subscribeButton.setTitle("SUBSCRIBE", for: .normal)
        subscribeButton.setTitleColor(Design.ShortsPlayer.subscribeButtonTextColor, for: .normal)
        subscribeButton.titleLabel?.font = FontBuilder.customFont(.shortsSubscribeButton)
        subscribeButton.backgroundColor = Design.ShortsPlayer.subscribeButtonBackgroundColor
        subscribeButton.layer.cornerRadius = Design.ShortsPlayer.subscribeButtonCornerRadius
        subscribeButton.contentEdgeInsets = Design.ShortsPlayer.subscribeButtonEdgeInsets
        subscribeButton.addTarget(self, action: #selector(subscribeButtonTapped), for: .touchUpInside)
        
        [avatarImageView, authorNameLabel, subscribeButton].forEach { authorContainer.addSubview($0) }
        contentView.addSubview(authorContainer)
    }
    
    private func configureButton(_ button: UIButton, imageName: String) {
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
    }
    
    private func configureButtonLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = .white
        label.font = Design.ShortsPlayer.buttonLabelFont
        label.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rightButtonSize = Design.ShortsPlayer.rightButtonSize
        let spacing = Design.ShortsPlayer.rightPanelSpacing
        let labelFont = Design.ShortsPlayer.buttonLabelFont
        
        imageView.frame = CGRect(
            x: 0,
            y: Design.ShortsPlayer.imageTopPadding,
            width: contentView.bounds.width,
            height: contentView.bounds.height - Design.ShortsPlayer.imageBottomPadding
        )
        
        avatarImageView.frame = CGRect(x: 0, y: 0, width: Design.ShortsPlayer.avatarSize, height: Design.ShortsPlayer.avatarSize)
        authorNameLabel.frame = CGRect(
            x: Design.ShortsPlayer.avatarSize + spacing,
            y: 0,
            width: authorNameLabel.intrinsicContentSize.width,
            height: Design.ShortsPlayer.avatarSize
        )
        subscribeButton.frame = CGRect(
            x: Design.ShortsPlayer.avatarSize + spacing + authorNameLabel.frame.width + spacing,
            y: 0,
            width: subscribeButton.intrinsicContentSize.width,
            height: Design.ShortsPlayer.avatarSize
        )
        let totalWidth = Design.ShortsPlayer.avatarSize + spacing + authorNameLabel.frame.width + spacing + subscribeButton.frame.width
        authorContainer.frame = CGRect(
            x: Design.ShortsPlayer.authorContainerLeftPadding,
            y: imageView.frame.maxY - Design.ShortsPlayer.authorContainerBottomOffset - Design.ShortsPlayer.avatarSize,
            width: totalWidth,
            height: Design.ShortsPlayer.avatarSize
        )
        
        let titleWidth = imageView.frame.width - rightButtonSize - Design.ShortsPlayer.titleRightPadding
        let titleHeight = titleLabel.text?.heightForWidth(titleWidth, font: titleLabel.font) ?? Design.ShortsPlayer.titleDefaultHeight
        titleLabel.frame = CGRect(
            x: Design.ShortsPlayer.titleLeftPadding,
            y: authorContainer.frame.minY - titleHeight - Design.ShortsPlayer.titleBottomSpacing,
            width: titleWidth,
            height: titleHeight
        )
        
        var totalHeight: CGFloat = 0
        for item in rightPanelItems {
            totalHeight += rightButtonSize
            if let label = item.label, let text = label.text, !text.isEmpty {
                totalHeight += text.heightForWidth(rightButtonSize, font: labelFont)
            }
            totalHeight += spacing
        }
        totalHeight += rightButtonSize
        
        var currentY = authorContainer.frame.maxY - totalHeight
        let panelX = contentView.bounds.width - rightButtonSize - Design.ShortsPlayer.rightPanelRightPadding
        
        for item in rightPanelItems {
            item.button.frame = CGRect(x: panelX, y: currentY, width: rightButtonSize, height: rightButtonSize)
            currentY += rightButtonSize
            if let label = item.label {
                let labelHeight = label.text?.heightForWidth(rightButtonSize, font: labelFont) ?? 14
                label.frame = CGRect(x: panelX, y: currentY, width: rightButtonSize, height: labelHeight)
                currentY += labelHeight
            }
            currentY += spacing
        }
        
        audioIcon.frame = CGRect(x: panelX, y: currentY, width: rightButtonSize, height: rightButtonSize)
    }
    
    func configure(with shorts: ShortsVideo) {
        imageView.image = UIImage(named: shorts.image)
        titleLabel.text = shorts.name
        
        authorNameLabel.text = shorts.chanel.name
        avatarImageView.image = UIImage(named: Design.ShortsPlayer.avatarPlaceholder)
        
        likesCountLabel.text = "\(shorts.likes.toShortString())"
        dislikesCountLabel.text = Design.ShortsPlayer.dislikeLabelText
        commentsCountLabel.text = "\(shorts.commentsCount.toShortString())"
        shareLabel.text = Design.ShortsPlayer.shareLabelText
    }
    
    private func setupButtonActions() {
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikeButtonTapped), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    @objc private func moreButtonTapped() {
        print("More about video")
    }
    
    @objc private func likeButtonTapped() {
        print("Like video")
    }
    
    @objc private func dislikeButtonTapped() {
        print("Dislike video")
    }
    
    @objc private func commentButtonTapped() {
        print("Comment video")
    }
    
    @objc private func shareButtonTapped() {
        print("Share video")
    }
    
    @objc private func subscribeButtonTapped() {
        print("Subscribe to chanel")
    }
}

