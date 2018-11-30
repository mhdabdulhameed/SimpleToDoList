//
//  ToDoDetailsPresenter.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol ToDoDetailsPresentationLogic: class {
    
    func dismiss()
}

final class ToDoDetailsPresenter: ToDoDetailsPresentationLogic {
    
    private let networkManager: NetworkManagerType
    private let toDoItem: ToDoItemViewModel?
    
    init(networkManager: NetworkManagerType = MoyaNetworkManager.shared, toDoItem: ToDoItemViewModel? = nil) {
        self.networkManager = networkManager
        self.toDoItem = toDoItem
    }
    
    func dismiss() {
        SceneCoordinator.shared.pop(animated: true) {
            
        }
    }
}
