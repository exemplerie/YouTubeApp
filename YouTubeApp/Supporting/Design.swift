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
}
