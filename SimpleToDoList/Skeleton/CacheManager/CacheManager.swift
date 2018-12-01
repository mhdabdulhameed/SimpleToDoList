//
//  CacheManager.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

final class CacheManager: CacheManagerType {
    
    static let shared = CacheManager()
    
    private var group: DispatchGroup!
    private let networkManager: NetworkManagerType
    private let dbService: ToDoDBServiceType
    
    private init(networkManager: NetworkManagerType = MoyaNetworkManager.shared, dbService: ToDoDBServiceType = RealmToDoService()) {
        self.networkManager = networkManager
        self.dbService = dbService
    }
    
    func add(operation: ItemCacheOperation) {
        dbService.addCacheOperation(operation: operation)
    }
    
    func sync(onComplete: @escaping () -> Void) {
        group = DispatchGroup()
        for operation in dbService.getCacheOperations() {
            group.enter()
            if let addItemOperation = operation as? AddItemCacheOperation {
                syncAddItem(operation: addItemOperation) { [weak self] in self?.group.leave() }
                
            } else if let updateItemOperation = operation as? UpdateItemCacheOperation {
                syncUpdateItem(operation: updateItemOperation) { [weak self] in self?.group.leave() }
                
            } else if let deleteItemOperation = operation as? DeleteItemCacheOperation {
                syncDeleteItem(operation: deleteItemOperation) { [weak self] in self?.group.leave() }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.dbService.deleteCacheOperations()
            onComplete()
        }
    }
    
    func hasCacheOperations() -> Bool {
        return dbService.hasCacheOperations()
    }
    
    func deleteCacheOperations() {
        dbService.deleteCacheOperations()
    }
    
    private func syncAddItem(operation: AddItemCacheOperation, onComplete: @escaping () -> Void) {
        let requestOnComplete: (Result<ToDoItem>) -> Void = { _ in onComplete() }
        
        networkManager.startRequest(api: .addToDo(title: operation.title), onComplete: requestOnComplete)
    }
    
    private func syncUpdateItem(operation: UpdateItemCacheOperation, onComplete: @escaping () -> Void) {
        let requestOnComplete: (Result<ToDoItem>) -> Void = { _ in onComplete() }
        
        networkManager.startRequest(api: .update(id: operation.id, title: operation.title, completed: operation.completed), onComplete: requestOnComplete)
    }
    
    private func syncDeleteItem(operation: DeleteItemCacheOperation, onComplete: @escaping () -> Void) {
        let requestOnComplete: (Result<IgnoredResponse>) -> Void = { _ in onComplete() }
        
        networkManager.startRequest(api: .deleteToDo(id: operation.id), onComplete: requestOnComplete)
    }
}
