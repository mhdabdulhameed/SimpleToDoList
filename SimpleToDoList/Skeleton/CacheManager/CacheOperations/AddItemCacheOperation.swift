//
//  AddItemCacheOperation.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 12/1/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import RealmSwift

class AddItemCacheOperation: ItemCacheOperation {
    @objc dynamic var title: String = ""
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
