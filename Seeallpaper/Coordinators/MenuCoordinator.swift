//
//  SearchCoordinator.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 6.12.2022.
//

import UIKit

class MenuCoordinator: Coordinator {
    
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationCommander: UINavigationController
    private let navigationSoldier = UINavigationController()
    
    var parentCoordinator: MainCoordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationCommander = navigationController
    }
    
    func start() {
        let searchViewController = MenuViewController()
        let searchVM = MenuViewModel()
        searchVM.coordinator = self
        searchVM.delegate = parentCoordinator
        searchViewController.searchVM = searchVM
        searchViewController.delegate = parentCoordinator
        navigationSoldier.modalPresentationStyle = .overCurrentContext
        navigationSoldier.setViewControllers([searchViewController], animated: false)
        navigationCommander.present(navigationSoldier, animated: false)
    }
    
    func menuClose() {
        parentCoordinator?.menuClose()
    }
    
    
}
