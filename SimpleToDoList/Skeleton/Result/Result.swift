//
//  Result.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

enum Result<ResponseModel>{
    case success(ResponseModel)
    case failure(Error)
}
