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
}
