//
//  ViewController.swift
//  SocialNetworkFeed
//
//  Created by admin on 3/7/2025.
//

import UIKit

final class TabBarVC: UITabBarController {
    lazy var newsVC = NewsFeedListVC()
    lazy var favoritesVC = FavoritesListVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navVC = UINavigationController(rootViewController: newsVC)
        navVC.tabBarItem.title = "Лента"
        navVC.tabBarItem.image = UIImage(systemName: "newspaper")
        
        let favVC = UINavigationController(rootViewController: favoritesVC)
        favVC.tabBarItem.title = "Закдадки"
        favVC.tabBarItem.image = UIImage(systemName: "bookmark")
        
        viewControllers = [navVC, favVC]
    }
    
}

