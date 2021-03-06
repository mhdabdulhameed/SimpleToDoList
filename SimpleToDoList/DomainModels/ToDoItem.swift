//
//  ToDoItem.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RealmSwift

class ToDoItem: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var completed: Bool = false
    @objc dynamic var order: Int = 1
    @objc dynamic var url: String = ""
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case completed
        case order
        case url
    }
}
