//
//  ShowSearchCoordinator.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 6.12.2022.
//

import UIKit


class SearchCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationCommander: UINavigationController
    private let navigationSoldier = UINavigationController()
    private let vm: Wallpaper
    var parentCoordinator: MainCoordinator?
    
    
    init(_ navigationController: UINavigationController, _ vm: Wallpaper) {
        self.navigationCommander = navigationController
        self.vm = vm
    }
    
    func start() {
        let showSearchViewController = SearchViewController()
        let showSearchVM = ShowSearchViewModel(vm)
        showSearchVM.coordinator = self
        showSearchViewController.showSearchVM = showSearchVM
        showSearchViewController.delegate = parentCoordinator
        showSearchViewController.delegatePop = parentCoordinator
        navigationSoldier.modalPresentationStyle = .overCurrentContext
        navigationSoldier.setViewControllers([showSearchViewController], animated: false)
        navigationCommander.present(navigationSoldier, animated: false)
    }
    
    func tappedSearch() {
        let searchCoordinator = MenuCoordinator(navigationSoldier)
        searchCoordinator.parentCoordinator = parentCoordinator
        searchCoordinator.start()
        childCoordinator.append(searchCoordinator)
    }
    
    func tappedBack() {
        navigationSoldier.dismiss(animated: true)
    }
    
}
