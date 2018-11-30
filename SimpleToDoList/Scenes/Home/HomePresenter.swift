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
    
    init(networkManager: NetworkManagerType = MoyaNetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func getToDoList(onComplete: @escaping ([ToDoItemViewModel]) -> Void) {
        let requestOnComplete: (Result<[ToDoItem]>) -> Void = { result in
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
