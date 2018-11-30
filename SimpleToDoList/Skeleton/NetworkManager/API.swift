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
    case addToDo(title: String, order: Int, completed: Bool)
    case deleteToDo(id: String)
    case update(id: String, title: String, completed: Bool)
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
        case .todos, .addToDo(_, _, _):
            return ""
        case .deleteToDo(let id), .update(let id, _, _):
            return "\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .todos:
            return .get
        case .addToDo:
            return .post
        case .deleteToDo:
            return .delete
        case .update:
            return .patch
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .todos:
            return .requestPlain
            
        case .addToDo(let title, let order, let completed):
            let parameters: [String: Any] = [
                "title": title,
                "order": order,
                "completed": completed
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .deleteToDo:
            return .requestPlain
            
        case .update(_, let title, let completed):
            let parameters: [String: Any] = [
                "title": title,
                "completed": completed
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .todos, .addToDo, .deleteToDo, .update:
            return nil
        }
    }
}
