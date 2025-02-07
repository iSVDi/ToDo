//
//  ToDoDetailsInteractorInput.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//


import Foundation

protocol ToDoDetailsInteractorInput: AnyObject {
    func saveChanges()
    func fetchLastCreatedTodo()
    func fetchTodo(by id: Int32)
}
