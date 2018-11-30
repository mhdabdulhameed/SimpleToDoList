//
//  AppDelegate.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        SceneCoordinator.shared = SceneCoordinator(window: window)
        let presenter = HomePresenter()
        let scene = Scene.home(presenter)
        SceneCoordinator.shared.transition(to: scene) {
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

