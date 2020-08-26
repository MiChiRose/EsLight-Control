//
//  AppDelegate.swift
//  EsLightControl
//
//  Created by Yura Menschikov on 6/16/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

// MARK: File for iOS 12 and older view controller
import UIKit

@available (iOS 13.0, *)
@UIApplicationMain

// MARK: - AppDelegate

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public properties

    var window: UIWindow?
    
    // MARK: - Public methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainController = ViewController()
        let navigationController = UINavigationController(rootViewController: mainController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        return true
    }

}
