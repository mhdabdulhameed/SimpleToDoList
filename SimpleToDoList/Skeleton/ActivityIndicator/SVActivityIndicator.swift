//
//  SVActivityIndicator.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import SVProgressHUD

final class SVActivityIndicator: ActivityIndicatorType {
    
    static let shared = SVActivityIndicator()
    
    private init() { }
    
    func show() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    func show(with message: String) {
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
