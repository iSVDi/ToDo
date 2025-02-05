//
//  DataManager.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import CoreData

class DataManager {
    static var context : NSManagedObjectContext {
        get {
            let context = CoreDataStack.shared.persistanceContainer.viewContext
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            return context
        }
    }
    
    static func save() {
        do {
            try context.save()
        } catch {
            print("Error while save context: \(error)")
        }
    }
    
    //MARK: ToDoModel
    static func getNewId() -> Int? {
        let fetchRequest = NSFetchRequest<ToDoModel>(entityName: "ToDoModel")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.fetchLimit = 1
        return try? context.fetch(fetchRequest).first?.id as? Int
    }
    
    static func createTodoModel() -> ToDoModel {
        guard let entity = NSEntityDescription.entity(forEntityName: "ToDoModel", in: DataManager.context),
              let managedObject = NSManagedObject(entity: entity, insertInto: DataManager.context) as? ToDoModel else { return .init()}
        return managedObject
    }
    
    static func fetchAllToDoModel() -> [ToDoModel] {
        let fetchRequest = NSFetchRequest<ToDoModel>(entityName: "ToDoModel")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let toDoModels = try? context.fetch(fetchRequest)
        return toDoModels ?? []
    }
}
