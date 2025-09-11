import UIKit

struct Design {
    struct TabBar {
        enum Icons {
            static let home = UIImage(named: "HomeIcon")
            static let shorts = UIImage(named: "ShortsIcon")
            static let addVideo = UIImage(named: "AddVideoIcon")
            static let subscriptions = UIImage(named: "SubscriptionsIcon")
            static let library = UIImage(named: "LibraryIcon")
        }
        
        enum IconsSelected {
            static let home = UIImage(named: "HomeIconSelected")
            static let subscriptions = UIImage(named: "SubscriptionsIconSelected")
            static let library = UIImage(named: "LibraryIconSelected")
        }
        
        enum Titles {
            static let home = "Home"
            static let shorts = "Shorts"
            static let subscriptions = "Subscription"
            static let library = "Library"
        }
        
        enum Fonts {
            static let title = FontBuilder.customFont(.tabBarTitles)
        }
    }
    
    enum VideoTable {
        enum Color {
            static let filterButtonsColor = UIColor(named: "elementsGray")
            static let borderColor = UIColor(named: "borderGray")
            static let filterSelectedColor = UIColor(named: "filterSelected")
            static let dataTextColor = UIColor(named: "textGray")
            static let shortsTitleBetaColor = UIColor(named: "shortsTitleBeta")
        }
    }
    
    enum ShortsCell {
        static let titleHorizontalPadding: CGFloat = 10
        static let titleHeight: CGFloat = 48
        static let titleBottomOffset: CGFloat = 12
        static let viewsLabelHeight: CGFloat = 20
        static let viewsLabelSpacing: CGFloat = 10
        static let viewsLabelBottomPadding: CGFloat = 10
    }
    
    enum ShortsTable {
        static let headerHeight: CGFloat = 57
        static let stripHeight: CGFloat = 8
        static let iconLeftPadding: CGFloat = 13
        static let iconTopPadding: CGFloat = 16
        static let iconWidth: CGFloat = 24
        static let iconHeight: CGFloat = 30
        static let labelSpacing: CGFloat = 8
        static let labelWidth: CGFloat = 50
        static let betaLabelSpacing: CGFloat = 3
        static let betaLabelWidth: CGFloat = 100
        static let betaLabelHeight: CGFloat = 24
        static let collectionViewHorizontalPadding: CGFloat = 13
        static let collectionViewTopPadding: CGFloat = 8
        static let collectionViewHeight: CGFloat = 280
        static let collectionViewSpacing: CGFloat = 15
        static let collectionViewItemSize = CGSize(width: 168, height: 280)
        static let collectionViewBottomPadding: CGFloat = 18
    }
    
    enum FiltersBar {
        static let backgroundColor: UIColor = .white
        static let exploreIconName = "exploreIcon"
        static let exploreTitle = "Explore"
        static let exploreTitleColor: UIColor = .black
        static let exploreCornerRadius: CGFloat = 4
        static let exploreImageInset: CGFloat = 10
        static let exploreTitleInset: CGFloat = 10
        static let exploreLeftPadding: CGFloat = 12
        static let exploreTopPadding: CGFloat = 13
        static let exploreWidth: CGFloat = 100
        static let exploreHeight: CGFloat = 39
        
        static let separatorColor: UIColor = .lightGray
        static let separatorAlpha: CGFloat = 0.5
        static let separatorWidth: CGFloat = 1
        static let separatorHeight: CGFloat = 24
        static let separatorLeftPadding: CGFloat = 14
        
        static let scrollLeftPadding: CGFloat = 14
        static let scrollRightPadding: CGFloat = 6
        static let scrollHeight: CGFloat = 39
        
        static let stackSpacing: CGFloat = 4
        
        static let buttonHeight: CGFloat = 34
        static let buttonCornerRadius: CGFloat = 17
        static let buttonHorizontalInset: CGFloat = 12
        static let buttonTitleColor: UIColor = .black
        
        static let allTitle = "All"
        static let selectionAnimationDuration: TimeInterval = 0.2
    }
    
    enum NavBar {
        static let youtubeLogoName = "youtubeLogo"
        static let youtubeLogoWidth: CGFloat = 99
        static let youtubeLogoHeight: CGFloat = 24
        static let youtubeLogoLeftPadding: CGFloat = 14
        
        static let tvCastIconName = "tvCastIcon"
        static let notificationsIconName = "notificationsIcon"
        static let searchIconName = "searchIcon"
        static let userProfileIconName = "userAvatar"
        static let userProfileCornerRadius: CGFloat = 12
        
        static let buttonSize: CGFloat = 24
        static let stackSpacing: CGFloat = 17
        static let stackRightPadding: CGFloat = 17
        
        static let separatorHeight: CGFloat = 0.5
    }
    
    enum HomePage {
        static let backgroundColor: UIColor = .white
        static let navBarHeight: CGFloat = 61
        static let filtersBarHeight: CGFloat = 64
        static let estimatedRowHeight: CGFloat = 340
        
        static let shortsRowIndex: Int = 1
        static let shortsRowHeight: CGFloat = 384
        static let fullLengthRowDefaultHeight: CGFloat = 340
    }
    
    enum FullLengthVideoCell {
        static let padding: CGFloat = 12
        static let previewHeight: CGFloat = 237
        static let avatarSize: CGFloat = 40
        static let labelRightMargin: CGFloat = 55
        static let viewsTopMargin: CGFloat = 8
        static let infoLabelHeight: CGFloat = 14
        static let infoLabelSpacing: CGFloat = 4
        static let settingsButtonRightMargin: CGFloat = 40
        static let settingsButtonSize: CGFloat = 24
        static let settingsIconName: String = "videoSettingsIcon"
        static let settingsButtonBottomMargin: CGFloat = 24
        
        static let backgroundColor = UIColor.white
        static let titleTextColor = UIColor.black
        static let dataTextColor = UIColor.gray
        static let settingsButtonTintColor = UIColor.black
        static let previewPlaceholderColor = UIColor.lightGray
        static let avatarPlaceholderColor = UIColor.systemGray4
        
    }
    
    enum CollectionSectionsIndex {
        static let fullLengthFirst: Int = 0
        static let shorts: Int = 1
    }
    
    enum ShortsFeed {
        static let backgroundColor: UIColor = .black
        
        static let collectionViewLineSpacing: CGFloat = 0
        static let collectionViewIsPagingEnabled: Bool = true
        
        static let backButtonImageName: String = "backArrow"
        static let backButtonTintColor: UIColor = .white
        static let backButtonLeftPadding: CGFloat = 20
        static let backButtonTopPadding: CGFloat = 5
        static let backButtonSize: CGFloat = 32
    }
    
    enum ShortsPlayer {
        static let backgroundColor: UIColor = .black
        static let titleColor: UIColor = .white
        static let moreButtonImage = "shortsMoreIcon"
        static let likeButtonImage = "likesIcon"
        static let dislikeButtonImage = "dislikesIcon"
        static let commentButtonImage = "commentsIcon"
        static let shareButtonImage = "shareIcon"
        static let audioIconImage = "shortsAudio"
        
        static let avatarSize: CGFloat = 30
        static let avatarBorderColor: UIColor = .white
        static let authorNameColor: UIColor = .white
        static let subscribeButtonTextColor: UIColor = .white
        static let subscribeButtonBackgroundColor: UIColor = .red
        static let subscribeButtonCornerRadius: CGFloat = 4
        static let subscribeButtonEdgeInsets = UIEdgeInsets(top: 6, left: 11, bottom: 6, right: 11)
        static let avatarPlaceholder = "shortsAvatar"
        static let dislikeLabelText = "Dislike"
        static let shareLabelText = "Share"
        
        static let rightButtonSize: CGFloat = 40
        static let rightPanelSpacing: CGFloat = 15
        static let rightPanelRightPadding: CGFloat = 20
        
        static let imageTopPadding: CGFloat = 110
        static let imageBottomPadding: CGFloat = 150
        
        static let authorContainerLeftPadding: CGFloat = 15
        static let authorContainerBottomOffset: CGFloat = 10
        
        static let titleLeftPadding: CGFloat = 16
        static let titleRightPadding: CGFloat = 90
        static let titleBottomSpacing: CGFloat = 20
        static let titleDefaultHeight: CGFloat = 90
        
        static let buttonLabelFont: UIFont = .systemFont(ofSize: 12)
    }
}
