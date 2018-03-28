//
//  CreateCompanyController.swift
//  CoreDataTest
//
//  Created by Dylan Bruschi on 3/27/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Company"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        view.backgroundColor = .darkBlue
    }
    
    @objc func handleCancel() {
        
    }
}
