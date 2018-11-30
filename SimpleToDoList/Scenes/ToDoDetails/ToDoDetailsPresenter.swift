//
//  ToDoDetailsPresenter.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Foundation

protocol ToDoDetailsPresentationLogic: class {
    
    /// Gets a list of the movies that being played in the cinemas now.
    ///
    /// - Parameters:
    ///   - page: The page number to retrieve.
    ///   - onComplete: A completion handler that takes an instance of `MoviesListViewModel` which contains the page's elements.
    //    func getToDoList(onComplete: @escaping (MoviesListViewModel) -> Void)
}

final class ToDoDetailsPresenter: ToDoDetailsPresentationLogic {
    
    private let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType = MoyaNetworkManager.shared) {
        self.networkManager = networkManager
    }
}
