//
//  ShowPaperCoordinator.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 4.12.2022.
//

import UIKit

class ShowPaperCoordinator: Coordinator {
    
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationCommander: UINavigationController
    private let navigationsSoldier = UINavigationController()
    let wallpaperModel: WallpaperModel?
    
    init(_ navigationCommander: UINavigationController, _ wallpaperModel: WallpaperModel) {
        self.navigationCommander = navigationCommander
        self.wallpaperModel = wallpaperModel
    }
    
    func start() {
        let showPaperViewController = ShowPaperViewController()
        showPaperViewController.wallpaperVM = wallpaperModel
        navigationsSoldier.modalTransitionStyle = .coverVertical
        navigationsSoldier.modalPresentationStyle = .currentContext
        navigationsSoldier.setViewControllers([showPaperViewController], animated: true)
        navigationCommander.present(navigationsSoldier, animated: true)

    }
}
