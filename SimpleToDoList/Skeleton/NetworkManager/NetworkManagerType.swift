//
//  NetworkManagerType.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

protocol NetworkManagerType {
    
    /// Starts a network request with the specified API End Point.
    ///
    /// - Parameter api: the End Point to call.
    /// - Parameter onComplete: Takes `Result<T>`.
    func startRequest<T: Codable>(api: API, onComplete: @escaping (Result<T>) -> Void)
}
