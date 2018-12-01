//
//  RealmToDoService.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RealmSwift

final class RealmToDoService: ToDoDBServiceType {
    
    func store(todoItems: [ToDoItem]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
        
        for item in todoItems {
            try! realm.write {
                realm.add(item)
            }
        }
    }
    
    func getTodoItems() -> [ToDoItem] {
        let realm = try! Realm()
        let items = Array(realm.objects(ToDoItem.self))
        return items
    }
}
