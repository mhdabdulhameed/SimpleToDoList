//
//  HomeViewController.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - Private Properties
    
    private let presenter: HomePresentationLogic
    
    private lazy var todosTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        return barButtonItem
    }()
    
    /// Initialize `NowPlayingViewController` with a `NowPlayingPresentationLogic` instance.
    init(with presenter: HomePresentationLogic) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
    }
    
    // MARK: - Private Methods
    
    /// Initializes the UI elements.
    private func initializeUI() {
        // Title
        title = Constants.HomeConstants.title
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        addTodosTableViewView()
    }
    
    /// Adds `todosTableView` to the view hierarchy and setups its constraints.
    private func addTodosTableViewView() {
        view.addSubview(todosTableView)
        setupTodosTableViewConstraints()
    }
    
    /// Sets the constraints of `todosTableView`.
    private func setupTodosTableViewConstraints() {
        todosTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        todosTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        todosTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        todosTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Add new todo item bar button item action.
    @objc private func addButtonTapped() {
        print("Add")
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(frame: .zero)
    }
}
