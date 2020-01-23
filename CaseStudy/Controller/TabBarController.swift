//
//  TabBarController.swift
//  CaseStudy
//
//  Created by Sevban Kocabas on 22.01.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createNavigationController(viewController: SearchGameViewController(), title: "Games", imageName: "gamesIcon"),
            
            createNavigationController(viewController: FavoriteGameListViewController(), title: "Favorites", imageName: "favoriteIcon")
        ]
        
        tabBar.barTintColor = UIColor.backgroundColor
        tabBar.tintColor = .buttonColor
    }
    
    private func createNavigationController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.tabBarItem.title = title
            navigationController.navigationBar.prefersLargeTitles = true
            viewController.title = title
            navigationController.tabBarItem.image = UIImage(named: imageName)
        navigationController.navigationBar.backgroundColor = .backgroundColor
            return navigationController
    }

}
