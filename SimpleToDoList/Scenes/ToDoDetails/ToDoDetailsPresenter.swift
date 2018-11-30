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
    var toDoItem: ToDoItemViewModel? { get set }
    
    func dismiss()
    func confirmButtonTapped(with title: String)
    
    func getTitleLabelText() -> String
    func getTitleTextFieldText() -> String?
    func getConfirmButtonTitleText() -> String
}

final class ToDoDetailsPresenter: ToDoDetailsPresentationLogic {
    
    weak var delegate: ToDoDetailsPresenterDelegate?
    private let networkManager: NetworkManagerType
    private let activityIndicator: ActivityIndicatorType
    var toDoItem: ToDoItemViewModel?
    
    private var isEditting: Bool {
        return toDoItem != nil
    }
    
    init(networkManager: NetworkManagerType = MoyaNetworkManager.shared, activityIndicator: ActivityIndicatorType = SVActivityIndicator.shared, toDoItem: ToDoItemViewModel? = nil) {
        self.networkManager = networkManager
        self.activityIndicator = activityIndicator
        self.toDoItem = toDoItem
    }
    
    func dismiss() {
        SceneCoordinator.shared.pop(animated: true) {
            
        }
    }
    
    func confirmButtonTapped(with title: String) {
        if let toDoItem = toDoItem {
            // Edit
            editToDoItem(of: toDoItem.id, with: title, and: toDoItem.completed)
        } else {
            // Add
            addNewToDoItem(with: title)
        }
    }
    
    func getTitleLabelText() -> String {
        if isEditting {
            return "Update the name of your to do item"
        } else {
            return "Enter the title of the new to do item"
        }
    }
    
    func getTitleTextFieldText() -> String? {
        return toDoItem?.title
    }
    
    func getConfirmButtonTitleText() -> String {
        if isEditting {
            return "Update"
        } else {
            return "Add"
        }
    }
    
    private func addNewToDoItem(with title: String) {
        activityIndicator.show()
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
    }
    
    private func editToDoItem(of id: String, with title: String, and completed: Bool) {
        activityIndicator.show()
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
