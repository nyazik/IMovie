//
//  MainTabViewController.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    private final let tmdb = TMDb(webservice: Webservice())
    
    lazy var topRatedMoviewVC: UINavigationController = {
        let viewController = TopRatedMoviesVC()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        viewController.tmdb = tmdb
        viewController.title = "Top Rated"
        
        return UINavigationController(rootViewController: viewController)
    }()
    
    lazy var discoveryMoviewVC: UINavigationController = {
        let viewController = DiscoveryVC()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        viewController.tabBarItem.title = "Up Coming"
        viewController.tmdb = tmdb
        viewController.title = "Up Coming"
        
        return UINavigationController(rootViewController: viewController)
    }()
    
    lazy var searchMovieVC: UINavigationController = {
        let viewController = SearchMovieVC()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        viewController.tmdb = tmdb
        viewController.title = "Search"
        
        return UINavigationController(rootViewController: viewController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarList = [topRatedMoviewVC, discoveryMoviewVC, searchMovieVC]
        viewControllers = tabBarList
    }
    
}

extension UIViewController {
    func showErrorMessage(of message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

