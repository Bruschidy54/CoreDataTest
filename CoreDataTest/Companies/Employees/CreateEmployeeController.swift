//
//  CreateEmployeeController.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 5/21/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        
        setupCancelButton()
        
        view.backgroundColor = .darkBlue
        
        _ = setupLightBlueBackgroundView(height: 50)
        
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        nameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        view.addSubview(nameTextField)
        
        nameTextField.anchor(top: nameLabel.topAnchor, left: nameLabel.rightAnchor, bottom: nameLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc private func handleSave() {
        
        guard let name = nameTextField.text else { return }
        let error = CoreDataManager.shared.createEmployee(name: name)
        
        if let error = error {
            // Present alert for error
            print(error)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
