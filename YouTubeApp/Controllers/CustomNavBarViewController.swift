import UIKit

class CustomNavBarViewController: UIViewController {
    private let youtubeLogo = UIImageView(image: UIImage(named: Design.NavBar.youtubeLogoName))
    private let tvCastButton = UIButton()
    private let notificationsButton = UIButton()
    private let searchButton = UIButton()
    private let userProfileButton = UIButton()
    private let buttonsStack = UIStackView()
    private let bottomSeparator = UIView()
    
    private lazy var actionButtons: [UIButton] = [
        tvCastButton,
        notificationsButton,
        searchButton,
        userProfileButton
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
        setupButtonActions()
    }
    
    private func setupViews() {
        setupButtons()
        setupStack()
        setupSeparator()
        
        view.addSubview(youtubeLogo)
        view.addSubview(buttonsStack)
        view.addSubview(bottomSeparator)
    }
    
    private func setupButtons() {
        let buttonImages = [
            tvCastButton: Design.NavBar.tvCastIconName,
            notificationsButton: Design.NavBar.notificationsIconName,
            searchButton: Design.NavBar.searchIconName,
            userProfileButton: Design.NavBar.userProfileIconName
        ]
        
        buttonImages.forEach { button, imageName in
            button.setImage(UIImage(named: imageName), for: .normal)
            button.imageView?.contentMode = .scaleAspectFill
        }
        
        userProfileButton.imageView?.layer.cornerRadius = Design.NavBar.userProfileCornerRadius
        userProfileButton.imageView?.clipsToBounds = true
    }
    
    private func setupStack() {
        actionButtons.forEach { buttonsStack.addArrangedSubview($0) }
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = Design.NavBar.stackSpacing
        buttonsStack.distribution = .fillEqually
    }
    
    private func setupSeparator() {
        bottomSeparator.backgroundColor = Design.VideoTable.Color.borderColor
    }
    
    private func setupButtonActions() {
        tvCastButton.addTarget(self, action: #selector(tvCastButtonTapped), for: .touchUpInside)
        notificationsButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        userProfileButton.addTarget(self, action: #selector(userProfileButtonTapped), for: .touchUpInside)
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
    
    private func layoutViews() {
        let buttonSize = Design.NavBar.buttonSize
        let stackWidth = (buttonSize * CGFloat(actionButtons.count)) + (buttonsStack.spacing * CGFloat(actionButtons.count - 1))
        
        youtubeLogo.frame = CGRect(
            x: Design.NavBar.youtubeLogoLeftPadding,
            y: (view.frame.height - Design.NavBar.youtubeLogoHeight) / 2,
            width: Design.NavBar.youtubeLogoWidth,
            height: Design.NavBar.youtubeLogoHeight
        )
        
        buttonsStack.frame = CGRect(
            x: view.frame.width - stackWidth - Design.NavBar.stackRightPadding,
            y: (view.frame.height - buttonSize) / 2,
            width: stackWidth,
            height: buttonSize
        )
        
        bottomSeparator.frame = CGRect(
            x: youtubeLogo.frame.minX,
            y: view.frame.height - Design.NavBar.separatorHeight,
            width: buttonsStack.frame.maxX - youtubeLogo.frame.minX,
            height: Design.NavBar.separatorHeight
        )
        
        actionButtons.forEach { $0.frame.size = CGSize(width: buttonSize, height: buttonSize) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
    }
}
