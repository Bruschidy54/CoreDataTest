//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 3/22/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
    func didEditCompany(company: Company) {
        
        let row = companies.index(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    func didAddCompany(company: Company) {
        companies.append(company)
        
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    
    let cellId = "cellId"
    var companies = [Company]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
       
        view.backgroundColor = .white
        
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            let company = self.companies[indexPath.row]
            
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            let context = CoreDataManager.shared.persistentContainer.viewContext
            
            context.delete(company)
            do {
            try context.save()
            } catch let saveErr {
                print("Failed to save company deletion:", saveErr)
            }
        }
        deleteAction.backgroundColor = UIColor.lightRed
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandleFunction)
        editAction.backgroundColor = UIColor.darkBlue
        
        return [deleteAction, editAction]
    }
    
    
    
    private func editHandleFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        print("Editing company in separate function")
        
        let editCompanyController = CreateCompanyController()
        editCompanyController.delegate = self
        editCompanyController.company = companies[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editCompanyController)
        present(navController, animated: true, completion: nil)
    }
    
    private func fetchCompanies() {

        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
        let companies = try context.fetch(fetchRequest)
            companies.forEach { (company) in
                print(company)
            }
            
            self.companies = companies
            self.tableView.reloadData()
        } catch let fetchErr {
            print("Failed to fetch companies", fetchErr)
        }
    }
    
    @objc func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        
        
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        
        present(navController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.backgroundColor = .tealColor
        
        let company = companies[indexPath.row]
        
        if let name = company.name, let founded = company.founded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            let foundedDateString = dateFormatter.string(from: founded)
            
            let dateString = "\(name) - Founded: \(foundedDateString)"
            
            cell.textLabel?.text = dateString
        } else {
            cell.textLabel?.text = company.name
        }
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        cell.imageView?.image = #imageLiteral(resourceName: "select_photo_empty")
        
        if let imageData = company.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }

}

