import UIKit

class FiltersBar: UIView {
    private let exploreButton = UIButton()
    private var filterButtons = [UIButton]()
    private let filtersStackView = UIStackView()
    private let filtersScrollView = UIScrollView()
    private let verticalSeparator = UIView()
    
    var onFilterSelected: ((VideoCategory?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Design.FiltersBar.backgroundColor
        setupViews()
        createFilterButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupExploreButton()
        setupVerticalSeparator()
        setupFiltersScrollView()
        setupStackView()
    }
    
    private func setupExploreButton() {
        addSubview(exploreButton)
        exploreButton.setImage(UIImage(named: Design.FiltersBar.exploreIconName), for: .normal)
        exploreButton.setTitle(Design.FiltersBar.exploreTitle, for: .normal)
        exploreButton.titleLabel?.font = FontBuilder.customFont(.exploreButton)
        exploreButton.setTitleColor(Design.FiltersBar.exploreTitleColor, for: .normal)
        exploreButton.backgroundColor = Design.VideoTable.Color.filterButtonsColor
        exploreButton.layer.cornerRadius = Design.FiltersBar.exploreCornerRadius
        exploreButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -Design.FiltersBar.exploreImageInset, bottom: 0, right: 0)
        exploreButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: Design.FiltersBar.exploreTitleInset, bottom: 0, right: 0)
        exploreButton.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
    }
    
    private func setupVerticalSeparator() {
        addSubview(verticalSeparator)
        verticalSeparator.backgroundColor = Design.FiltersBar.separatorColor
        verticalSeparator.alpha = Design.FiltersBar.separatorAlpha
    }
    
    private func setupFiltersScrollView() {
        addSubview(filtersScrollView)
        filtersScrollView.showsHorizontalScrollIndicator = false
        filtersScrollView.addSubview(filtersStackView)
    }
    
    private func setupStackView() {
        filtersStackView.axis = .horizontal
        filtersStackView.spacing = Design.FiltersBar.stackSpacing
        filtersStackView.alignment = .fill
        filtersStackView.distribution = .fill
    }
    
    private func createFilterButtons() {
        let categories = [Design.FiltersBar.allTitle] + VideoCategory.allCases.map { $0.rawValue }
        
        categories.forEach { category in
            let button = makeFilterButton(title: category)
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            filterButtons.append(button)
            filtersStackView.addArrangedSubview(button)
        }
        
        setSelectedFilter(nil)
    }
    
    private func makeFilterButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = FontBuilder.customFont(.videoCategoryButton)
        button.setTitleColor(Design.FiltersBar.buttonTitleColor, for: .normal)
        button.backgroundColor = Design.VideoTable.Color.filterButtonsColor
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: Design.FiltersBar.buttonHorizontalInset, bottom: 0, right: Design.FiltersBar.buttonHorizontalInset)
        button.layer.borderWidth = 1
        button.layer.borderColor = Design.VideoTable.Color.borderColor?.cgColor
        button.layer.cornerRadius = Design.FiltersBar.buttonCornerRadius
        button.clipsToBounds = true
        return button
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        let selectedCategory = VideoCategory(rawValue: sender.title(for: .normal) ?? "")
        setSelectedFilter(selectedCategory)
        onFilterSelected?(selectedCategory)
    }
    
    func setSelectedFilter(_ filter: VideoCategory?) {
        filterButtons.forEach { button in
            let isSelected = (filter == nil && button.title(for: .normal) == Design.FiltersBar.allTitle) ||
                             (button.title(for: .normal) == filter?.rawValue)
            updateButtonAppearance(button, isSelected: isSelected)
        }
    }
    
    private func updateButtonAppearance(_ button: UIButton, isSelected: Bool) {
        UIView.animate(withDuration: Design.FiltersBar.selectionAnimationDuration) {
            button.backgroundColor = isSelected
                ? Design.VideoTable.Color.filterSelectedColor
                : Design.VideoTable.Color.filterButtonsColor
            button.setTitleColor(isSelected ? .white : .black, for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        exploreButton.frame = CGRect(
            x: Design.FiltersBar.exploreLeftPadding,
            y: Design.FiltersBar.exploreTopPadding,
            width: Design.FiltersBar.exploreWidth,
            height: Design.FiltersBar.exploreHeight
        )
        
        verticalSeparator.frame = CGRect(
            x: exploreButton.frame.maxX + Design.FiltersBar.separatorLeftPadding,
            y: exploreButton.frame.midY - Design.FiltersBar.separatorHeight / 2,
            width: Design.FiltersBar.separatorWidth,
            height: Design.FiltersBar.separatorHeight
        )
        
        filtersScrollView.frame = CGRect(
            x: verticalSeparator.frame.maxX + Design.FiltersBar.scrollLeftPadding,
            y: exploreButton.frame.minY,
            width: frame.width - verticalSeparator.frame.maxX - Design.FiltersBar.scrollRightPadding,
            height: Design.FiltersBar.scrollHeight
        )
        
        layoutFilterButtons()
    }
    
    private func layoutFilterButtons() {
        var xOffset: CGFloat = 0
        
        filterButtons.forEach { button in
            let text = button.title(for: .normal) ?? ""
            let font = button.titleLabel?.font ?? UIFont.systemFont(ofSize: 14)
            let buttonWidth = (text as NSString).size(withAttributes: [.font: font]).width + Design.FiltersBar.buttonHorizontalInset * 2
            
            button.frame = CGRect(x: xOffset, y: 0, width: buttonWidth, height: Design.FiltersBar.buttonHeight)
            button.layer.cornerRadius = Design.FiltersBar.buttonHeight / 2
            xOffset += buttonWidth + Design.FiltersBar.stackSpacing
        }
        
        let yOffset = (exploreButton.frame.height - Design.FiltersBar.buttonHeight) / 2
        filtersStackView.frame = CGRect(x: 0, y: yOffset, width: xOffset, height: Design.FiltersBar.buttonHeight)
        filtersScrollView.contentSize = CGSize(width: xOffset, height: filtersScrollView.frame.height)
    }
    
    @objc private func exploreButtonTapped() {
        print("Explore videos")
    }
}
