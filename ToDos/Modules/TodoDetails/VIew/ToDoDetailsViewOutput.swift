//
//  ToDoDetailsViewOutput.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//


import Foundation

struct ToDoDetails {
    let title: String
    let description: String
}

protocol ToDoDetailsViewOutput: AnyObject {
    
    func viewDidLoadHandler()
    //update todo
    func saveTodo(todoDetails: ToDoDetails)
    
}
