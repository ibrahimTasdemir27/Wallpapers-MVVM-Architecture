//
//  ShowPopCoordinator.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 5.12.2022.
//

import UIKit

class ShowContentCoordinator: Coordinator {
    
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationCommander: UINavigationController
    private let navigationSoldier = UINavigationController()
    private let vm: WallpaperModel?
    
    init(_ navigationController: UINavigationController,_ vm: WallpaperModel) {
        self.navigationCommander = navigationController
        self.vm = vm
    }
    
    func start() {
        let contentViewController = ContentViewController()
        contentViewController.wallpaperVM = vm
        navigationSoldier.modalTransitionStyle = .crossDissolve
        navigationSoldier.modalPresentationStyle = .overCurrentContext
        navigationSoldier.setViewControllers([contentViewController], animated: true)
        navigationCommander.present(navigationSoldier, animated: true)
    }
}
