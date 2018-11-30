//
//  ToDoTableViewCell.swift
//  SimpleToDoList
//
//  Created by Mohamed Abdul-Hameed on 11/30/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

import UIKit

final class ToDoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ToDoTableViewCell"
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var completedCheckBox: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(nil, for: [])
        return button
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addCompletedCheckBox()
        addTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(with viewModel: ToDoItemViewModel) {
        titleLabel.text = viewModel.title
        let image = viewModel.completed ? UIImage(named: "ItemChecked")! : UIImage(named: "ItemNotChecked")!
        completedCheckBox.setImage(image, for: [])
    }
    
    // MARK: - Private Methods
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        setupTitleLabelConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: completedCheckBox.leftAnchor, constant: 15).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        layoutIfNeeded()
    }
    
    private func addCompletedCheckBox() {
        addSubview(completedCheckBox)
        setupCompletedCheckBoxConstraints()
    }
    
    private func setupCompletedCheckBoxConstraints() {
        completedCheckBox.topAnchor.constraint(equalTo: topAnchor).isActive = true
        completedCheckBox.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        completedCheckBox.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        completedCheckBox.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        layoutIfNeeded()
    }
}
