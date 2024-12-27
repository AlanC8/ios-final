//
//  TabBarViewController.swift
//  final-project
//
//  Created by Алан Абзалханулы on 26.12.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad(){
        super.viewDidLoad()
        let homeViewController = HomeViewController()
        let profileViewController = ProfileViewController()
        let favoritesViewController = FavoritesViewController()
        
        homeViewController.title = "Home"
        profileViewController.title = "Profile"
        favoritesViewController.title = "Favorites"
        
        homeViewController.navigationItem.largeTitleDisplayMode = .always
        profileViewController.navigationItem.largeTitleDisplayMode = .always
        favoritesViewController.navigationItem.largeTitleDisplayMode = .always
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        homeNavigationController.navigationBar.prefersLargeTitles = true
        profileNavigationController.navigationBar.prefersLargeTitles = true
        favoritesNavigationController.navigationBar.prefersLargeTitles = true
        viewControllers = [homeNavigationController,favoritesNavigationController, profileNavigationController]
        
        setViewControllers(viewControllers, animated: false)
    }
}
