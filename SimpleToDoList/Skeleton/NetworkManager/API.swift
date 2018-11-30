//
//  API.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import Moya

enum API {
    case todos
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.ApiConstants.baseURL) else {
            fatalError("Base URL couldn't be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .todos:
            return Constants.ApiConstants.todosPath
        }
    }
    
    var method: Method {
        switch self {
        case .todos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .todos:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .todos:
            return nil
        }
    }
}
