//
//  HomePresenter.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol HomePresentationLogic: class {
    
    var view: HomeViewLogic? { get set }
    
    func goToAddScene()
    func getToDoList(onComplete: @escaping ([ToDoItemViewModel]) -> Void)
    func deleteToDoItem(with id: String, onComplete: @escaping (Bool) -> Void)
    func markToDoItemCompleted(with id: String, title: String, completed: Bool, onComplete: @escaping (Bool) -> Void)
}

protocol ToDoDetailsPresenterDelegate: class {
    func newToDoItemAdded(item: ToDoItem)
    func updateToDoItem(item: ToDoItem)
}

final class HomePresenter: HomePresentationLogic {
    
    weak var view: HomeViewLogic?
    private let networkManager: NetworkManagerType
    private let activityIndicator: ActivityIndicatorType
    
    init(networkManager: NetworkManagerType = MoyaNetworkManager.shared, activityIndicator: ActivityIndicatorType = SVActivityIndicator.shared) {
        self.networkManager = networkManager
        self.activityIndicator = activityIndicator
    }
    
    func goToAddScene() {
        let presenter = ToDoDetailsPresenter()
        presenter.delegate = self
        let scene = Scene.todoItemDetails(presenter, .add)
        SceneCoordinator.shared.transition(to: scene) {
            
        }
    }
    
    func getToDoList(onComplete: @escaping ([ToDoItemViewModel]) -> Void) {
        activityIndicator.show(with: "Getting Your To Do Items...")
        let requestOnComplete: (Result<[ToDoItem]>) -> Void = { [weak self] result in
            self?.activityIndicator.dismiss()
            switch result {
            case .success(let todoList):
                onComplete(todoList.map { ToDoItemViewModel(with: $0) })
            case .failure(let error):
                // TODO show error.
                print(error)
            }
        }
        
        networkManager.startRequest(api: .todos, onComplete: requestOnComplete)
    }
    
    func deleteToDoItem(with id: String, onComplete: @escaping (Bool) -> Void) {
        onComplete(true)
    }
    
    func markToDoItemCompleted(with id: String, title: String, completed: Bool, onComplete: @escaping (Bool) -> Void) {
        activityIndicator.show()
        let requestOnComplete: (Result<ToDoItem>) -> Void = { [weak self] result in
            self?.activityIndicator.dismiss()
            switch result {
            case .success(_):
                onComplete(true)
            case .failure(let error):
                // TODO show error.
                onComplete(false)
                print(error)
            }
        }
        
        networkManager.startRequest(api: .update(id: id, title: title, completed: completed), onComplete: requestOnComplete)
    }
}

extension HomePresenter: ToDoDetailsPresenterDelegate {
    func newToDoItemAdded(item: ToDoItem) {
        view?.addNewItem(item: ToDoItemViewModel(with: item))
    }
    
    func updateToDoItem(item: ToDoItem) {
        view?.updateItem(of: item.id, with: item.title)
    }
}
