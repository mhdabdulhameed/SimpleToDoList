//
//  SceneCoordinatorType.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

protocol SceneCoordinatorType {
    init(window: UIWindow)
    
    func transition(to scene: TargetScene, onComplete: @escaping (() -> Void))
}
