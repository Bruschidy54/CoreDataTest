//
//  CreateEmployeeController.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 5/21/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    var delegate: CreateEmployeeControllerDelegate?
    
    var company: Company?
    
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
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/DD/YYYY"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let employeeTypeSegmentedControl: UISegmentedControl = {
        let types = [
            EmployeeType.Executive.rawValue,
            EmployeeType.SeniorManagement.rawValue,
            EmployeeType.Staff.rawValue
        ]
        let sc = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.darkBlue
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        
        setupCancelButton()
        
        view.backgroundColor = .darkBlue
        
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    private func setupUI() {
        
           _ = setupLightBlueBackgroundView(height: 150)
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        view.addSubview(nameTextField)
        nameTextField.anchor(top: nameLabel.topAnchor, left: nameLabel.rightAnchor, bottom: nameLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(birthdayLabel)
        birthdayLabel.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 100, height: 50)
        
        view.addSubview(birthdayTextField)
        birthdayTextField.anchor(top: birthdayLabel.topAnchor, left: birthdayLabel.rightAnchor, bottom: birthdayLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(employeeTypeSegmentedControl)
        employeeTypeSegmentedControl.anchor(top: birthdayLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 34)
    }
    
    @objc private func handleSave() {
        
        guard let name = nameTextField.text else { return }
        guard let company = company else { return }
        
        guard let birthdayText = birthdayTextField.text else { return }
        
        if birthdayText.isEmpty {
            showError(title: "Empty Birthday", message: "You have not entered a birthday")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY"
        
        guard let birthdayDate = dateFormatter.date(from: birthdayText) else {
            showError(title: "Invalid Date", message: "Please enter a birthday in the format MM/DD/YYYY")
            return }
        
        guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else { return }
        
        let tuple = CoreDataManager.shared.createEmployee(name: name, employeeType: employeeType, birthday: birthdayDate, company: company)
        
        if let error = tuple.1 {
            // Present alert for error
            print(error)
        } else {
            dismiss(animated: true) {
                guard let employee = tuple.0 else { return }
                self.delegate?.didAddEmployee(employee: employee)
            }
        }
    }
    
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
