//
//  EmployeesController.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 5/21/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit
import CoreData

class EmployeesController: UITableViewController {
    
    var company: Company?
    
    var employees = [Employee]()
    
    let cellId = "EmployeeCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.title = company?.name
        
        fetchEmployees()
    }
    
    private func fetchEmployees() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        do {
        let employees = try context.fetch(request)
        self.employees = employees
                } catch let err {
            print("Failed to fetch employees:", err)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.darkBlue
        
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    @objc private func handleAdd() {
        
        let createEmployeeController = CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createEmployeeController)
        
        present(navController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let employee = employees[indexPath.row]
        cell.textLabel.text = employee.name
        cell.backgroundColor = UIColor.tealColor
        cell.textLabel?.text = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        return cell
    }
}
