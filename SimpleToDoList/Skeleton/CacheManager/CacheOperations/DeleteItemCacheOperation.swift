//
//  DeleteItemCacheOperation.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RealmSwift

class DeleteItemCacheOperation: ItemCacheOperation {
    @objc dynamic var id: String = ""
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}
