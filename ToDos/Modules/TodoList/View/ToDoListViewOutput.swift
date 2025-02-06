//
//  ToDoListViewOutput.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//


import Foundation

protocol ToDoListViewOutput: AnyObject {
    func viewDidLoadHandler()
    func getAllTodos() -> [ToDo]
    func didTapCell(cellId: Int)
    func createTodo()
    func editTodo(id: Int)
    func deleteTodo(cellId: Int)
    func searchBy(text: String)
}
