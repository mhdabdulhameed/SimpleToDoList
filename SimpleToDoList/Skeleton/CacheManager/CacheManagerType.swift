//
//  CacheManagerType.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

protocol CacheManagerType {
    func sync(onComplete: @escaping () -> Void)
    func deleteCacheOperations()
    func hasCacheOperations() -> Bool
    func add(operation: ItemCacheOperation)
}
