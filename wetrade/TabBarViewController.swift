//
//  HomeViewController.swift
//  wetrade
//
//  Created by Kazim Walji on 4/1/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let HomeVC = tableView()
        let ProfileVC = ProfileViewController()
        ProfileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.icloud"), selectedImage: UIImage(systemName: "person.icloud"))
        HomeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), selectedImage: UIImage(systemName: "homekit"))
        self.viewControllers = [HomeVC, ProfileVC]
    }
    
}
