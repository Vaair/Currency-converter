//
//  SceneDelegate.swift
//  Конвертер валют
//
//  Created by Лера Тарасенко on 09.03.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        window?.makeKeyAndVisible()
        
        self.window?.overrideUserInterfaceStyle = .light
        
        let mainVC = ViewController()
        let navigationVC = UINavigationController(rootViewController: mainVC)
        self.window?.rootViewController = navigationVC
    }

}

