//
//  UITabbarController+Ext.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import UIKit.UITabBarController

extension UITabBarController {
    func instantiate(_ vc : [UIViewController]) {
        let images = ["house","gear.circle"]
        let title = ["Ana Sayfa","Ayarlar"]
        var vc = vc
        vc = vc.map({
            return UINavigationController(rootViewController: $0)
        })
        self.setViewControllers(vc, animated: true)
        guard let items = self.tabBar.items else {
            return
        }
        for i in 0...vc.count - 1 {
            items[i].image = UIImage(systemName: images[i])
            vc[i].title = title[i]
        }
    }
}
