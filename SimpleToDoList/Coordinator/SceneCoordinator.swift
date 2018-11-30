//
//  SceneCoordinator.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

/**
 Scene coordinator, manage scene navigation and presentation.
 */

class SceneCoordinator: NSObject, SceneCoordinatorType {
    
    static var shared: SceneCoordinator!
    
    private var window: UIWindow
    private var currentViewController: UIViewController? {
        didSet {
            currentViewController?.navigationController?.delegate = self
        }
    }
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        var controller = viewController
        if let tabBarController = controller as? UITabBarController {
            guard let selectedViewController = tabBarController.selectedViewController else {
                return tabBarController
            }
            controller = selectedViewController
        }
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first!
        }
        return viewController
    }
    
    func transition(to scene: TargetScene, onComplete: @escaping (() -> Void)) {
        switch scene.transition {
            
        case let .tabBar(tabBarController):
            guard let selectedViewController = tabBarController.selectedViewController else {
                fatalError("Selected view controller doesn't exists")
            }
            currentViewController = SceneCoordinator.actualViewController(for: selectedViewController)
            window.rootViewController = tabBarController
            
        case let .root(viewController):
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = viewController
            onComplete()
            
        case let .push(viewController):
            guard let navigationController = currentViewController?.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            navigationController.pushViewController(SceneCoordinator.actualViewController(for: viewController), animated: true)
            
        case let .present(viewController):
            currentViewController?.present(viewController, animated: true) {
                onComplete()
            }
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            
        case let .alert(viewController):
            currentViewController?.present(viewController, animated: true) {
                onComplete()
            }
        }
    }
    
    func pop(animated: Bool, onComplete: @escaping (() -> Void)) {
        if let presentingViewController = currentViewController?.presentingViewController {
            currentViewController?.dismiss(animated: animated) {
                self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
                onComplete()
            }
        } else if let navigationController = currentViewController?.navigationController {
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(currentViewController)")
            }
            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
            navigationController.popViewController(animated: true)
            
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension SceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}

// MARK: - UITabBarControllerDelegate

extension SceneCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)  {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}
