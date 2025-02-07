//
//  ToDoModel+CoreDataProperties.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//
//

import Foundation
import CoreData


extension ToDoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoModel> {
        return NSFetchRequest<ToDoModel>(entityName: "ToDoModel")
    }

    @NSManaged public var creationDate: Date
    @NSManaged public var details: String
    @NSManaged public var id: Int32
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String

}

extension ToDoModel : Identifiable {

}
