//
//  HomeViewController.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

protocol ToDoTableViewCellDelegate: class {
    func didTapCheckBox(with tag: Int, didChangeStatusSuccessfully: @escaping (Bool) -> Void)
}

protocol HomeViewLogic: class {
    func updateItem(of id: String, with title: String)
    func addNewItem(item: ToDoItemViewModel)
}

final class HomeViewController: BaseViewController {
    
    // MARK: - Private Properties
    
    private let presenter: HomePresentationLogic
    private var todoList = [ToDoItemViewModel]()
    
    private lazy var todosTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        return barButtonItem
    }()
    
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
        getToDoList()
    }
    
    // MARK: - Private Methods
    
    /// Initializes the UI elements.
    private func initializeUI() {
        // Title
        title = Constants.HomeConstants.title
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addTodosTableViewView()
    }
    
    private func getToDoList() {
        presenter.getToDoList() { [weak self] todoList in
            guard let self = self else { return }
            self.todoList = todoList
            self.todosTableView.reloadData()
        }
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
        presenter.goToAddScene(with: nil)
    }
    
    private func editToDoItem(at indexPath: IndexPath) {
        presenter.goToAddScene(with: todoList[indexPath.row])
    }
    
    private func deleteToDoItem(at indexPath: IndexPath) {
        presenter.deleteToDoItem(with: todoList[indexPath.row].id) { [weak self] success in
            self?.todoList.remove(at: indexPath.row)
            self?.todosTableView.performBatchUpdates({ [weak self] in
                self?.todosTableView.deleteRows(at: [indexPath], with: .automatic)
            })
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Edit
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { [weak self] action, indexPath in
            self?.editToDoItem(at: indexPath)
        }
        editAction.backgroundColor = .lightGray
        
        // Delete
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            self?.deleteToDoItem(at: indexPath)
        }
        deleteAction.backgroundColor = .red
        
        return [deleteAction, editAction]
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier, for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        cell.configure(with: self, and: todoList[indexPath.row])
        cell.tag = indexPath.row
        return cell
    }
}

extension HomeViewController: ToDoTableViewCellDelegate {
    func didTapCheckBox(with tag: Int, didChangeStatusSuccessfully: @escaping (Bool) -> Void) {
        let todoItem = todoList[tag]
        presenter.markToDoItemCompleted(with: todoItem.id, title: todoItem.title, completed: !todoItem.completed) { success in
            didChangeStatusSuccessfully(success)
        }
    }
}

extension HomeViewController: HomeViewLogic {
    func updateItem(of id: String, with title: String) {
        todoList.enumerated().forEach { index, element in
            if element.id == id {
                element.title = title
                DispatchQueue.main.async { [weak self] in
                    self?.todosTableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
                }
            }
        }
    }
    
    func addNewItem(item: ToDoItemViewModel) {
        todoList.append(item)
        todosTableView.performBatchUpdates({ [weak self] in
            guard let self = self else { return }
            self.todosTableView.insertRows(at: [IndexPath(item: self.todoList.count - 1, section: 0)], with: .automatic)
        })
    }
}
