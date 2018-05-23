//
//  CoreDataManager.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 4/27/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestDataModels")
        container.loadPersistentStores { (storeDescription, err) in
            
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func fetchCompanies() -> [Company] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            return companies
            
        } catch let fetchErr {
            print("Failed to fetch companies", fetchErr)
            return []
        }
    }
    
    func createEmployee(name: String, employeeType: String, birthday: Date, company: Company) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        employee.company = company
        employee.type = employeeType
        
        employee.setValue(name, forKey: "name")
        
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
        
        employeeInformation.birthday = birthday
        
        employee.employeeInformation = employeeInformation
        
        do {
            try context.save()
            return (employee, nil)
        } catch let err {
            print("Failed to create employee", err)
            return (nil, err)
        }
    }
}
