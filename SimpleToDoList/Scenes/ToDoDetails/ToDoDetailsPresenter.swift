//
//  ToDoDetailsPresenter.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol ToDoDetailsPresentationLogic: class {
    
    var delegate: ToDoDetailsPresenterDelegate? { get set }
    
    func dismiss()
    func addToDoItem(title: String)
    func editToDoItem(of id: String, with title: String, and completed: Bool)
}

final class ToDoDetailsPresenter: ToDoDetailsPresentationLogic {
    
    weak var delegate: ToDoDetailsPresenterDelegate?
    private let networkManager: NetworkManagerType
    private let activityIndicator: ActivityIndicatorType
    private let toDoItem: ToDoItemViewModel?
    
    init(networkManager: NetworkManagerType = MoyaNetworkManager.shared, activityIndicator: ActivityIndicatorType = SVActivityIndicator.shared, toDoItem: ToDoItemViewModel? = nil) {
        self.networkManager = networkManager
        self.activityIndicator = activityIndicator
        self.toDoItem = toDoItem
    }
    
    func dismiss() {
        SceneCoordinator.shared.pop(animated: true) {
            
        }
    }
    
    func addToDoItem(title: String) {
        let requestOnComplete: (Result<ToDoItem>) -> Void = { [weak self] result in
            self?.activityIndicator.dismiss()
            switch result {
            case .success(let todoItem):
                self?.delegate?.newToDoItemAdded(item: todoItem)
            case .failure(let error):
                // TODO show error.
                print(error)
            }
            self?.dismiss()
        }
        
        networkManager.startRequest(api: .addToDo(title: title), onComplete: requestOnComplete)
        
        dismiss()
    }
    
    func editToDoItem(of id: String, with title: String, and completed: Bool) {
        let requestOnComplete: (Result<ToDoItem>) -> Void = { [weak self] result in
            self?.activityIndicator.dismiss()
            switch result {
            case .success(let todoItem):
                self?.delegate?.updateToDoItem(item: todoItem)
            case .failure(let error):
                // TODO show error.
                print(error)
            }
            self?.dismiss()
        }
        
        networkManager.startRequest(api: .update(id: id, title: title, completed: completed), onComplete: requestOnComplete)
    }
}
