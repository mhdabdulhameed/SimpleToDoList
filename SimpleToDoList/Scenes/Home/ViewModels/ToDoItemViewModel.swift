//
//  ToDoItemViewModel.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

class ToDoItemViewModel {
    let id: String
    let title: String
    var completed: Bool
    
    init(with model: ToDoItem) {
        self.id = model.id
        self.title = model.title
        self.completed = model.completed
    }
}
