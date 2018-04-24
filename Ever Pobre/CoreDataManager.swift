//
//  CoreDataManager.swift
//  Ever Pobre
//
//  Created by Manuel Perez Soriano on 21/4/18.
//  Copyright © 2018 Manuel Perez Soriano. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EverPobre")
        container.loadPersistentStores { (storeDescriotion, err) in
            if let err = err {
                fatalError("Loading of store \(err)")
            }
        }
        return container
    }()
}
