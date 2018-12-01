//
//  ToDoDBServiceType.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

protocol ToDoDBServiceType {
    func store(todoItems: [ToDoItem])
    func getTodoItems() -> [ToDoItem]
    func updateToDoItem(with id: String, title: String, completed: Bool)
    func deleteToDoItem(with id: String)
    func hasCacheOperations() -> Bool
    func deleteCacheOperations()
    func addCacheOperation(operation: ItemCacheOperation)
    func getCacheOperations() -> [ItemCacheOperation]
}
