//
//  ToDoListInteractorOutput.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//


import Foundation

protocol ToDoListInteractorOutput: AnyObject {
    func getAllTodoSuccess(_ todos: [ToDoEntity])
    func getAllCoreDataTodoSuccess(_ todos: [ToDo])
    func getAllTodoFailure()
}