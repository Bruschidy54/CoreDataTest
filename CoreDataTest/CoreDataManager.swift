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
}
