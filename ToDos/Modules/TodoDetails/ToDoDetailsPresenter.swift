//
//  ToDoDetailsPresenter.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//

import Foundation

class ToDoDetailsPresenter {
    weak var viewInput: ToDoDetailsViewInput?
    var interactor: ToDoDetailsInteractorInput?
    
    private let todoState: ToDoState
    
    init(todoState: ToDoState) {
        self.todoState = todoState
    }
    
}


extension ToDoDetailsPresenter: ToDoDetailsViewOutput {
    func viewDidLoadHandler() {
        switch todoState {
        case .view:
            interactor?.createNewTodo()
        case .edit(let todoId):
            interactor?.fetchTodo(by: todoId)
        }
        
    }
    
    func viewWillDisapearHandler() {
        // TODO: implement
    }
    
    
    
}

extension ToDoDetailsPresenter: ToDoDetailsInteractorOutput {
    func getTodoSuccess(_ todo : ToDo) {
        if case .view = todoState {
            viewInput?.disableUserInteraction()
        }
        viewInput?.setupData(todo: todo)
    }
    
    func getTodoFailure() {
        // TODO: implement
    }
    
    
}




