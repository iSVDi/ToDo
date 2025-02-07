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
    private var todoModel: ToDoModel?
    
    init(todoState: ToDoState) {
        self.todoState = todoState
    }
    
}


extension ToDoDetailsPresenter: ToDoDetailsViewOutput {
    func viewDidLoadHandler() {
        switch todoState {
        case .edit(let todoId):
            interactor?.fetchTodo(by: todoId)
        case .create:
            interactor?.fetchLastCreatedTodo()
        }
        
    }
    
    func saveTodo(todoDetails: ToDoDetails) {
        guard let todoModel, shoudUpdateTodo(todoDetails: todoDetails) else { return }
        todoModel.title = todoDetails.title
        todoModel.details = todoDetails.description
        interactor?.saveChanges()
    }
}

extension ToDoDetailsPresenter: ToDoDetailsInteractorOutput {
    func getTodoModelSuccess(_ todoModel: ToDoModel) {
        self.todoModel = todoModel
        viewInput?.setupData(todo: todoModel.mapToTodo())
    }
    
    func getTodoFailure() {
        // TODO: implement
    }
    
    
}

private extension ToDoDetailsPresenter {
    func shoudUpdateTodo(todoDetails: ToDoDetails) -> Bool {
        guard let todoModel else { return false}
        return todoModel.title != todoDetails.title || todoModel.details != todoDetails.description
    }
}




