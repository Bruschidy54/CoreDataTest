//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 3/22/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
    
    let cellId = "cellId"
    let companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
         Company(name: "Facebook", founded: Date())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        view.backgroundColor = .yellow
        
        navigationItem.title = "Companies"
        
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        
    }
    
    @objc func handleAddCompany() {
        let createCompanyController = UIViewController()
        createCompanyController.view.backgroundColor = .green
        
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
        
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return cell
    }

}

