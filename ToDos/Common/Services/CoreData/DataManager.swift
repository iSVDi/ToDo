//
//  DataManager.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import CoreData

class DataManager {
    private static let modelName = "ToDoModel"
    
    static var todoModelFetchRequest: NSFetchRequest<ToDoModel> {
        return NSFetchRequest<ToDoModel>(entityName: DataManager.modelName)
    }
    
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
    static func getMaxId() -> Int32 {
        let fetchRequest = todoModelFetchRequest
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.fetchLimit = 1
        do {
            return try context.fetch(fetchRequest).first?.id ?? 0
        } catch {
            LogService.error("Error while getMaxId: \(error)")
        }
        return -1
    }
    
    static func createTodoModel() -> ToDoModel {
        guard let entity = NSEntityDescription.entity(forEntityName: DataManager.modelName, in: DataManager.context),
              let managedObject = NSManagedObject(entity: entity, insertInto: DataManager.context) as? ToDoModel else { return .init() }
        return managedObject
    }
    
    static func fetchAllTodoModel() -> [ToDoModel] {
        let fetchRequest = todoModelFetchRequest
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        let todoModels = try? context.fetch(fetchRequest)
        return todoModels ?? []
    }
    
    static func fetchTodoModel(by id: Int32) -> ToDoModel? {
        let fetchRequest = todoModelFetchRequest
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let todoModel = try context.fetch(fetchRequest).first
            return todoModel
        } catch {
            LogService.error("Error while fetchTodoModel ToDo: \(error)")
        }
        return nil
    }
    
    static func fetchLastCreatedTodo() -> ToDoModel? {
        let fetchRequest = todoModelFetchRequest
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.fetchLimit = 1
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            LogService.error("Error while fetchLastCreatedTodo: \(error)")
        }
        return nil
    }
    
    static func updateIsCompletedTodoState(id: Int32) {
        let fetchRequest = todoModelFetchRequest
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let todoModel = try context.fetch(fetchRequest).first
            todoModel?.isCompleted.toggle()
            save()
        } catch {
            LogService.error("Error while updateIsCompletedTodoState ToDo: \(error)")
        }
    }
    
    static func deleteTodo(id: Int32) {
        let fetchRequest = todoModelFetchRequest
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            guard let todoModel = try context.fetch(fetchRequest).first else {
                //TODO: handle
                return
            }
            context.delete(todoModel)
            save()
        } catch {
            LogService.error("Error while deleteTodo: \(error)")
        }
    }
}
