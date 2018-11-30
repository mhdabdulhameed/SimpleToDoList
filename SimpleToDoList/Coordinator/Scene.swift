//
//  Scene.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

/**
 Refers to a screen managed by a view controller.
 It can be a regular screen, or a modal dialog.
 It comprises a view controller and a view model.
 */

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case home(HomePresentationLogic)
    case todoItemDetails(ToDoDetailsPresentationLogic, Mode)
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .home(let presenter):
            let viewController = HomeViewController(with: presenter)
            presenter.view = viewController
            let navigationController = UINavigationController(rootViewController: viewController)
            return .root(navigationController)
            
        case .todoItemDetails(let presenter, let mode):
            let viewController = ToDoDetailsViewController(with: presenter, and: mode)
            let navigationController = UINavigationController(rootViewController: viewController)
            return .present(navigationController)
        }
    }
}
