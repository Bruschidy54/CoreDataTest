//
//  CompaniesController+CreateCompany.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 5/20/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

extension CompaniesController: CreateCompanyControllerDelegate {
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
}
