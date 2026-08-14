//
//  TabBarController.swift
//  Zoo App
//
//  Created by Javid Sultanov on 13.08.26.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        let homeController = HomeController()
        homeController.tabBarItem = .init(title: "Home",
                                          image: UIImage(systemName: "house"),
                                          tag: 0)
        let homeNavigation = UINavigationController(rootViewController: homeController)
        
        let searchController = SearchController()
        searchController.tabBarItem = .init(title: "Search",
                                            image: UIImage(systemName: "magnifyingglass"),
                                            tag: 0)
        let searchNavigation = UINavigationController(rootViewController: searchController)
        
        let favoritesController = FavoritesController()
        favoritesController.tabBarItem = .init(title: "Favorites",
                                               image: UIImage(systemName: "star"),
                                               tag: 0)
        let favoritesNavigation = UINavigationController(rootViewController: favoritesController)
        
        viewControllers = [homeNavigation, searchNavigation, favoritesNavigation]
    }
}
