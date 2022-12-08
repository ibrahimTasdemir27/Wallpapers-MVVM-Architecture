//
//  SceneDelegate.swift
//  Seeallpaper
//
//  Created by İbrahim Taşdemir on 3.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.appCoordinator = AppCoordinator(window)
        self.appCoordinator?.start()
    }
}

