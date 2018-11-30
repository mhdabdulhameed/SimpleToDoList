//
//  ToDoItem.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

class ToDoItem: Codable {
    let id: String
    let title: String
    let completed: Bool
    let order: Int
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case completed
        case order
        case url
    }
}
