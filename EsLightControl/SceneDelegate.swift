//
//  SceneDelegate.swift
//  EsLightControl
//
//  Created by Yura Menschikov on 6/16/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

// MARK: File for iOS 13 viewCOntroller

import UIKit

@available (iOS 13.0, *)

// MARK: - SceneDelegate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public properties

    var window: UIWindow?
    
    // MARK: - Public methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainController)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.rootViewController = navigationController
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }

}
