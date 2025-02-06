//
//  ToDoListInteractorImpl.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import Moya
import OSLog

protocol ToDoListPresenterToInteractor: AnyObject {
    func fetchAllTodos()
    func fetchAllTodosFromStore()
    func updateToDoState(id: Int32)
}

final class ToDoListInteractorImpl: ToDoListPresenterToInteractor {
    weak var presenter: ToDoListInteractorToPresenter?
    private let provider = MoyaProvider<ToDoDataFetcher>()
    private let logger = Logger()

    func fetchAllTodos() {
        provider.request(.getAllTodos) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                do {
                    let todoBunch = try JSONDecoder().decode(ToDoBunch.self, from: response.data)
                    presenter?.getAllTodoSuccess(todoBunch.todos)
                } catch {
                    self.logger.error("error while request all todos: \(error)")
                }
                
            case .failure(let errror):
                logger.error("Bad getAllToDos request \(errror) ")
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
    
    
}
