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
        
        presenter?.getTodoModelSuccess(todoModel)
    }
    
    func saveChanges() {
        DataManager.save()
    }
    
    
    func fetchLastCreatedTodo() {
        guard let todoModel = DataManager.fetchLastCreatedTodo() else {
            presenter?.getTodoFailure()
            return
        }
        presenter?.getTodoModelSuccess(todoModel)
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
