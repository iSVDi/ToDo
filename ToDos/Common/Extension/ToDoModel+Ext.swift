//
//  ToDoModel+Ext.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//


import Foundation

extension ToDoModel {
    
    func mapToTodo() -> ToDo {
        ToDo(
            id: id,
            title: title,
            description: details,
            isCompleted: isCompleted,
            creationDate: creationDate
        )
    }
}