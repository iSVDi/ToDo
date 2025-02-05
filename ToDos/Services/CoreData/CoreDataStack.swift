//
//  CoreDataStack.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import UIKit
import CoreData

class CoreDataStack: NSObject {
    static let shared = CoreDataStack()
    lazy var persistanceContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ToDoModel")
        
        container.loadPersistentStores { _, error in
            guard let error else { return }
            fatalError("Failed to load persistance stores: \(error.localizedDescription)")
        }
        return container
    }()
}

