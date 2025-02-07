//
//  ToDoDetailsInteractor.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//

import Foundation

class ToDoDetailsInteractor: ToDoDetailsInteractorInput {
    weak var presenter: ToDoDetailsInteractorOutput?
    
    func fetchTodo(by id: Int32) {
        
        guard let todoModel = DataManager.fetchTodoModel(by: id) else {
            presenter?.getTodoFailure()
            return
        }
        
        let todo = todoModel.mapToTodo()
        presenter?.getTodoSuccess(todo)
    }
    
    func createNewTodo() {
        let todoModel = DataManager.createTodoModel()
        todoModel.title = "Untitled"
        todoModel.details = "Empty description"
        todoModel.creationDate = .now
        todoModel.isCompleted = false
        let todo = todoModel.mapToTodo()
        
        presenter?.getTodoSuccess(todo)
    }
}

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
