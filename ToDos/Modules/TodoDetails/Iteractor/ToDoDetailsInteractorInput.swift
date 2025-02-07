//
//  ToDoDetailsInteractorInput.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//


import Foundation

protocol ToDoDetailsInteractorInput: AnyObject {
    func fetchTodo(by id: Int32)
    func createNewTodo()
}
