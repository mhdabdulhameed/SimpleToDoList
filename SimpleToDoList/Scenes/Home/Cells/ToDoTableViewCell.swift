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
    
    private weak var delegate: ToDoTableViewCellDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var completedSwitch: UISwitch = {
        let completedSwitch = UISwitch(frame: .zero)
        completedSwitch.translatesAutoresizingMaskIntoConstraints = false
        completedSwitch.addTarget(self, action: #selector(completedSwitchValueChanged), for: .valueChanged)
        return completedSwitch
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addcompletedSwitch()
        addTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(with delegate: ToDoTableViewCellDelegate, and viewModel: ToDoItemViewModel) {
        self.delegate = delegate
        titleLabel.text = viewModel.title
        completedSwitch.isOn = viewModel.completed
    }
    
    // MARK: - Private Methods
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        setupTitleLabelConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: completedSwitch.leftAnchor, constant: 15).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        layoutIfNeeded()
    }
    
    private func addcompletedSwitch() {
        addSubview(completedSwitch)
        setupcompletedSwitchConstraints()
    }
    
    private func setupcompletedSwitchConstraints() {
        completedSwitch.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        completedSwitch.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        completedSwitch.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        completedSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        layoutIfNeeded()
    }
    
    @objc private func completedSwitchValueChanged() {
        delegate?.didTapCheckBox(with: tag) { [weak self] success in
            if !success {
                self?.completedSwitch.isOn = false
            }
        }
    }
}
