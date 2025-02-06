//
//  ToDoListInteractorInput.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//


import Foundation
import Moya

protocol ToDoListInteractorInput: AnyObject {
    func fetchAllTodos()
    func fetchAllTodosFromStore()
    func updateToDoState(id: Int32)
    func deleteToDo(id: Int32)
}
