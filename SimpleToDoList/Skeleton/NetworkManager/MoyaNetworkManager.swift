//
//  MoyaNetworkManager.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Moya

final class MoyaNetworkManager: NetworkManagerType {
    
    static let shared = MoyaNetworkManager()
    
    private lazy var provider: MoyaProvider<API> = {
        return MoyaProvider<API>(plugins: plugins)
    }()
    
    private lazy var plugins: [PluginType] = {
        return [/*NetworkLoggerPlugin(verbose: true)*/]
    }()
    
    private init() { }
    
    func startRequest<T: Codable>(api: API, onComplete: @escaping (Result<T>) -> Void) {
        provider.request(api) { result in
            switch result {
            case .success(let response):
                do {
                    if T.self == IgnoredResponse.self {
                        let responseModel = IgnoredResponse() as! T
                        onComplete(Result.success(responseModel))
                    } else {
                        let responseModel = try JSONDecoder().decode(T.self, from: response.data)
                        onComplete(.success(responseModel))
                    }
                    
                } catch let error {
                    onComplete(.failure(error))
                }
                
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
