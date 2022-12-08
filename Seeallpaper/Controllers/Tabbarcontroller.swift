//
//  Tabbarcontroller.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import UIKit

class TabBarController {
    
    private let tabBarcontroller: UITabBarController
    private let navigationController: UINavigationController
    
    init(_ tabBarcontroller: UITabBarController, _ navigationController: UINavigationController) {
        self.tabBarcontroller = tabBarcontroller
        self.navigationController = navigationController
    }
    
    func setupTabbar(vc: [UIViewController]) {
        navigationController.navigationBar.isHidden = true
        tabBarcontroller.instantiate(vc)
        tabBarcontroller.tabBar.backgroundColor = .systemGray6
        tabBarcontroller.tabBar.tintColor = .secondaryColor
    }
    
}
