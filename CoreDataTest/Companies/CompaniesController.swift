//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 3/22/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {
    
    
    let cellId = "cellId"
    var companies = [Company]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.companies = CoreDataManager.shared.fetchCompanies()
       
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset)),
        UIBarButtonItem(title: "Nested Updates", style: .plain, target: self, action: #selector(doNestedUpdates))
        ]
        
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
        
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
        
    }
    
    @objc private func doNestedUpdates() {
        
        DispatchQueue.global(qos: .background).async {
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            
            privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
            
            let request: NSFetchRequest<Company> = Company.fetchRequest()
            
            do {
                let companies = try privateContext.fetch(request)
                
                do {
                    try privateContext.save()
                    
                    DispatchQueue.main.async {
                        
                        do {
                                let context = CoreDataManager.shared.persistentContainer.viewContext
                            
                            if context.hasChanges {
                                try context.save()
                            }
                            
                            self.tableView.reloadData()
                        } catch let saveErr {
                            print("Failed to save main context:", saveErr)
                        }
                    }
                } catch let saveErr {
                    print("Failed to save on private context:", saveErr)
                }
            } catch let fetchErr {
                print("Failed to fetch on private context:", fetchErr)
            }
        }
    }
    
    
    @objc private func handleReset() {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
        try context.execute(batchDeleteRequest)
        
            var indexPathsToRemove = [IndexPath]()
            
            for (index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            companies.removeAll()
           tableView.deleteRows(at: indexPathsToRemove, with: .left)
        } catch let delErr {
            print("Failed to delete objects from Core Data:", delErr)
        }
    }
    
    
    @objc func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        
        
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        
        present(navController, animated: true, completion: nil)
    }
    
    
   
}

