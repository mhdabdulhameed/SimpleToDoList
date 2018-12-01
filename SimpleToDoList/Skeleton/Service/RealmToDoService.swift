//
//  RealmToDoService.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RealmSwift

final class RealmToDoService: ToDoDBServiceType {
    
    func store(todoItem: ToDoItem) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(todoItem)
        }
    }
    
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
    
    func updateToDoItem(with id: String, title: String, completed: Bool) {
        let dbItem = getTodoItems().filter { $0.id == id }.first
        let realm = try! Realm()
        try! realm.write {
            dbItem?.title = title
            dbItem?.completed = completed
        }
    }
    
    func deleteToDoItem(with id: String) {
        let realm = try! Realm()
        let dbItem = getTodoItems().filter { $0.id == id }.first
        guard let itemToDelete = dbItem else { return }
        try! realm.write {
            realm.delete(itemToDelete)
        }
    }
    
    func hasCacheOperations() -> Bool {
        let cacheOperations = getCacheOperations()
        return !cacheOperations.isEmpty
    }
    
    func deleteCacheOperations() {
        let realm = try! Realm()
        let cacheOperations = realm.objects(ItemCacheOperation.self)
        try! realm.write {
            realm.delete(cacheOperations)
        }
    }
    
    func addCacheOperation(operation: ItemCacheOperation) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(operation)
        }
    }
    
    func getCacheOperations() -> [ItemCacheOperation] {
        let realm = try! Realm()
        
        let addItemCacheOperations = Array(realm.objects(AddItemCacheOperation.self))
        let updateItemCacheOperations = Array(realm.objects(UpdateItemCacheOperation.self))
        let deleteItemCacheOperations = Array(realm.objects(DeleteItemCacheOperation.self))
        
        return addItemCacheOperations.map { $0 as ItemCacheOperation } +
            updateItemCacheOperations.map { $0 as ItemCacheOperation } +
            deleteItemCacheOperations.map { $0 as ItemCacheOperation }
    }
}
