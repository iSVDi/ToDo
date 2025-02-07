//
//  ToDoListInteractor.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import Moya

final class ToDoListInteractor: ToDoListInteractorInput {
    weak var presenter: ToDoListInteractorOutput?
    private let provider = MoyaProvider<ToDoDataFetcher>()

    func createEmptyTodo() {
        let todo = DataManager.createTodoModel()
        todo.id = DataManager.getMaxId() + 1
        todo.title = "Untitled"
        todo.isCompleted = false
        todo.creationDate = .now
        DataManager.save()
    }
    
    func fetchAllTodos() {
        provider.request(.getAllTodos) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    let todoBunch = try JSONDecoder().decode(ToDoBunch.self, from: response.data)
                    presenter?.getAllTodoSuccess(todoBunch.todos)
                } catch {
                    LogService.error("error while request all todos: \(error)")
                }
                
            case .failure(let errror):
                LogService.error("Bad getAllToDos request \(errror) ")
            }
        }
    }
    
    func fetchAllTodosFromStore() {
        let todos = DataManager.fetchAllTodoModel().map {
            ToDo(
                id: $0.id,
                title: $0.title,
                description: $0.details,
                isCompleted: $0.isCompleted,
                creationDate: $0.creationDate
            )
        }
        presenter?.getAllCoreDataTodoSuccess(todos)
    }
    
    func updateToDoState(id: Int32) {
        DataManager.updateIsCompletedTodoState(id: id)
    }
    
    func deleteToDo(id: Int32) {
        DataManager.deleteTodo(id: id)
    }
    
}
