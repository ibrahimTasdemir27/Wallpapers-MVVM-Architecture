//
//  MainCoordinator.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import UIKit

protocol ShowPaperDelegate {
    func pressItemShowPaper(vm: WallpaperModel,nav: UINavigationController)
}

protocol ShowPaperPopDelegate {
    func pressLongItemShowPaper(vm: WallpaperModel,nav: UINavigationController)
    func stopShowItem(nav: UINavigationController)
}

protocol ServiceDelegate {
    func getService<T>(resource: Resource<T>,completion: @escaping(Wallpaper) -> Void)
}

protocol SearchDelegate {
    func didSearchShowResults(vm: Wallpaper, nav: UINavigationController)

}

class MainCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    
    private let navigationCommander: UINavigationController
    private let tabBarcontroller: UITabBarController
    private let mainViewController = MainViewController()
    
    init(_ navigationController: UINavigationController, _ tabBarcontroller: UITabBarController) {
        self.navigationCommander = navigationController
        self.tabBarcontroller = tabBarcontroller
    }
    
    func start() {
        let wallpaperListVM = WallpaperListViewModel()
        let setttingsViewController = SettingsViewController()
        let vc = [mainViewController,setttingsViewController]
        let tabBar = TabBarController(tabBarcontroller,navigationCommander)
        mainViewController.delegate = self
        mainViewController.delegatePop = self
        wallpaperListVM.coordinator = self
        wallpaperListVM.delegate = self
        wallpaperListVM.responseService()
        mainViewController.wallpaperListVM = wallpaperListVM
        tabBar.setupTabbar(vc: vc)
    }
    
    func tappedSearch() {
        let searchCoordinator = MenuCoordinator(navigationCommander)
        searchCoordinator.parentCoordinator = self
        searchCoordinator.start()
        childCoordinator.append(searchCoordinator)
    }
    
    func menuClose() {
        navigationCommander.dismiss(animated: false)
    }
    
}

extension MainCoordinator: ShowPaperDelegate {
    func pressItemShowPaper(vm: WallpaperModel,nav: UINavigationController) {
        let showPaperCoordinator = ShowPaperCoordinator(nav,vm)
        childCoordinator.append(showPaperCoordinator)
        showPaperCoordinator.start()
    }
}

extension MainCoordinator: ShowPaperPopDelegate {
    func pressLongItemShowPaper(vm: WallpaperModel,nav: UINavigationController) {
        let showContentCoordinator = ShowContentCoordinator(nav,vm)
        childCoordinator.append(showContentCoordinator)
        showContentCoordinator.start()
    }
    func stopShowItem(nav: UINavigationController) {
        if ((mainViewController.parent) != nil) {
            nav.dismiss(animated: true)
        }
    }
}

extension MainCoordinator: ServiceDelegate {
    func getService<T>(resource: Resource<T>, completion: @escaping (Wallpaper) -> Void) where T : Decodable {
        Webservice.shared.load(resource: resource) { wallpaper in
            if let wallpaper = wallpaper as? Wallpaper {
                completion(wallpaper)
            }
        }
    }
}

extension MainCoordinator: SearchDelegate {
    func didSearchShowResults(vm: Wallpaper, nav: UINavigationController) {
        //navigationCommander.dismiss(animated: false)
        let showSearchCoordinator = SearchCoordinator(nav,vm)
        showSearchCoordinator.parentCoordinator = self
        showSearchCoordinator.start()
        childCoordinator.append(showSearchCoordinator)
    }
}
