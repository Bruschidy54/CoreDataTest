//
//  EmployeesController.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 5/21/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {

    
    
    func didAddEmployee(employee: Employee) {
        
        guard let section = employeeTypes.index(of: employee.type!) else { return }
        
        let row = allEmployees[section].count
        
        let insertionIndexPath = IndexPath(row: row, section: section)
        allEmployees[section].append(employee)
        
        tableView.insertRows(at: [insertionIndexPath], with: .middle)
    }
    
    
    var company: Company?
    
    var allEmployees = [[Employee]]()
    
    var employeeTypes = [
    EmployeeType.Executive.rawValue,
    EmployeeType.SeniorManagement.rawValue,
    EmployeeType.Staff.rawValue
    ]
    
    let cellId = "EmployeeCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.title = company?.name
        
    }
    
    private func fetchEmployees() {
        guard let companyEmployees = company?.employees?.allObjects as? [Employee] else { return }
        
        allEmployees = []
        
        employeeTypes.forEach { (employeeType) in
            allEmployees.append(
                companyEmployees.filter{ $0.type == employeeType }
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.darkBlue
        
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchEmployees()
    }
    
    @objc private func handleAdd() {
        
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.company = company
        let navController = CustomNavigationController(rootViewController: createEmployeeController)
        
        present(navController, animated: true, completion: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        
        label.text = employeeTypes[section]
        label.backgroundColor = UIColor.lightBlue
        label.textColor = UIColor.darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let employee = allEmployees[indexPath.section][indexPath.row]
        print(employee)
        cell.textLabel?.text = employee.name
        
        // TO DO: see why birthday is not displaying
        if let birthday = employee.employeeInformation?.birthday {
            //Display brithday properly?
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            cell.textLabel?.text = "\(employee.name ?? "")    \(dateFormatter.string(from: birthday))"
        }
        cell.backgroundColor = UIColor.tealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        return cell
    }
}
