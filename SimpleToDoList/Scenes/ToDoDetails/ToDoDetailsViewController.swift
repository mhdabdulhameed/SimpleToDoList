//
//  ToDoDetailsViewController.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

enum Mode {
    case add
    case edit
}

final class ToDoDetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let presenter: ToDoDetailsPresentationLogic
    private let mode: Mode
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(28.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var confirmButton: UIButton = {
       let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        return barButtonItem
    }()
    
    init(with presenter: ToDoDetailsPresentationLogic, and mode: Mode) {
        self.presenter = presenter
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
    }
    
    private func initializeUI() {
        view.backgroundColor = .white
        
        switch mode {
        case .add:
            titleLabel.text = "Enter a title for the new item"
            confirmButton.setTitle("Done", for: [])
        case .edit:
            titleLabel.text = "Enter a title to update the old title with"
            confirmButton.setTitle("Update", for: [])
        }
        
        titleTextField.placeholder = "New Name"
        
        title = Constants.ToDoDetailsConstants.title
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        addTitleTextField()
        addTitleLabel()
        addConfirmButton()
    }
    
    private func addTitleLabel() {
        view.addSubview(titleLabel)
        setupTitleLabelConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.centerXAnchor.constraint(equalTo: titleTextField.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: titleTextField.widthAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor, constant: -150.0).isActive = true
        
        view.layoutIfNeeded()
    }
    
    private func addTitleTextField() {
        view.addSubview(titleTextField)
        setupTitleTextFieldConstraints()
    }
    
    private func setupTitleTextFieldConstraints() {
        titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        view.layoutIfNeeded()
    }
    
    private func addConfirmButton() {
        view.addSubview(confirmButton)
        setupConfirmButtonConstraints()
    }
    
    private func setupConfirmButtonConstraints() {
        confirmButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20.0).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: titleTextField.centerXAnchor).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        view.layoutIfNeeded()
    }
    
    @objc private func confirmButtonTapped() {
        switch mode {
        case .add:
            print("Confirm for add")
        case .edit:
            print("Confirm for edit")
        }
    }
    
    @objc private func cancelButtonTapped() {
        presenter.dismiss()
    }
}
