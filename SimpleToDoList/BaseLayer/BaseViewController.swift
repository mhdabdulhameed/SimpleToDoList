//
//  BaseViewController.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
    }
    
    /// A method to customize the appearance of the `BaseViewController` to give all the view controllers that inherit it a unified appearance.
    private func customizeUI() {
        
    }
}
