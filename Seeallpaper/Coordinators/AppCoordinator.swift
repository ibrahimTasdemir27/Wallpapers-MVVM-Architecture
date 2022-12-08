//
//  AppCoordinator.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] {get}
    func start()
}

class AppCoordinator : Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = UITabBarController()
        let navigationController = UINavigationController(rootViewController: tabBarController)
        let mainCoordinator = MainCoordinator(navigationController,tabBarController)
        self.childCoordinator.append(mainCoordinator)
        mainCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
