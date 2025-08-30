import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.tabBar.unselectedItemTintColor = .black
        self.tabBar.tintColor = .black
                
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: Design.TabBar.Fonts.title]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    
    private func setupTabs() {
        let home = createNavigationController(
            title: Design.TabBar.Titles.home,
            image: Design.TabBar.Icons.home,
            imageSelected: Design.TabBar.IconsSelected.home,
            vc: HomePageController())
        let shorts = createNavigationController(
            title: Design.TabBar.Titles.shorts,
            image: Design.TabBar.Icons.shorts,
            imageSelected: nil,
            vc: ShortsFeedController())
        let addVideo = createNavigationController(
            title: nil,
            image: Design.TabBar.Icons.addVideo,
            imageSelected: nil,
            vc: AddVideoPageController())
        let subscriptions = createNavigationController(
            title: Design.TabBar.Titles.subscriptions,
            image: Design.TabBar.Icons.subscriptions,
            imageSelected: Design.TabBar.IconsSelected.subscriptions,
            vc: SubscriptionsPageController())
        let library = createNavigationController(
            title: Design.TabBar.Titles.library,
            image: Design.TabBar.Icons.library,
            imageSelected: Design.TabBar.IconsSelected.library,
            vc: LibraryPageController())
        
        addVideo.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -8, right: 0)
        
        self.setViewControllers( [home, shorts, addVideo, subscriptions, library], animated: true)
    }
    
    private func createNavigationController(title: String?, image: UIImage?, imageSelected: UIImage?, vc: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        if imageSelected != nil {
            navController.tabBarItem.selectedImage = imageSelected
        }
        
        return navController
    }
}
