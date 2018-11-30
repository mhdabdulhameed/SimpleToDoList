//
//  ToDoDetailsViewController.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

final class ToDoDetailsViewController: UIAlertController {
    
    // MARK: - Private Properties
    
    private let presenter: ToDoDetailsPresentationLogic
    
    /// Initialize `NowPlayingViewController` with a `NowPlayingPresentationLogic` instance.
    init(with presenter: ToDoDetailsPresentationLogic) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
