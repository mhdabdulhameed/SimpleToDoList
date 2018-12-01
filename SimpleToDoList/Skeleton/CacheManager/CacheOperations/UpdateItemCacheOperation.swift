//
//  UpdateItemCacheOperation.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RealmSwift

class UpdateItemCacheOperation: ItemCacheOperation {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var completed: Bool = false
    
    convenience init(id: String, title: String, completed: Bool) {
        self.init()
        self.id = id
        self.title = title
        self.completed = completed
    }
}
