//
//  HomePresenter.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol HomePresentationLogic: class {
    
    /// Gets a list of the movies that being played in the cinemas now.
    ///
    /// - Parameters:
    ///   - page: The page number to retrieve.
    ///   - onComplete: A completion handler that takes an instance of `MoviesListViewModel` which contains the page's elements.
    func getToDoList(onComplete: @escaping ([ToDoItemViewModel]) -> Void)
}

final class HomePresenter: HomePresentationLogic {
    
    private let networkManager: NetworkManagerType
    private let activityIndicator: ActivityIndicatorType
    
    init(networkManager: NetworkManagerType = MoyaNetworkManager.shared, activityIndicator: ActivityIndicatorType = SVActivityIndicator.shared) {
        self.networkManager = networkManager
        self.activityIndicator = activityIndicator
    }
    
    func getToDoList(onComplete: @escaping ([ToDoItemViewModel]) -> Void) {
        activityIndicator.show(with: "Getting Your To Do Items...")
        let requestOnComplete: (Result<[ToDoItem]>) -> Void = { [weak self] result in
            self?.activityIndicator.dismiss()
            switch result {
            case .success(let moviesList):
                onComplete(moviesList.map { ToDoItemViewModel(with: $0) })
            case .failure(let error):
                // TODO show error.
                print(error)
            }
        }
        
        networkManager.startRequest(api: .todos, onComplete: requestOnComplete)
    }
}
