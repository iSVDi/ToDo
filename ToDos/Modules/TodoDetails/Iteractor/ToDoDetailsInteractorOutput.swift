//
//  ToDoDetailsInteractorOutput.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//


import Foundation

protocol ToDoDetailsInteractorOutput: AnyObject {
    func getTodoSuccess(_ todo: ToDo)
    func getTodoFailure()
}