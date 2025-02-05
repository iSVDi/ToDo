//
//  ToDoListPresenter.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation

protocol ToDoListViewToPresenter: AnyObject {
    func viewDidLoadHandler()
    func getAllTodos() -> [ToDo]
    func didTapCell(id: Int)
    func createTodo()
    func editTodo(id: Int)
    func deleteTodo(id: Int)
    func searchBy(text: String)
}

protocol ToDoListInteractorToPresenter: AnyObject {
    func getAllTodoSuccess(todos: [ToDoEntity])
    func getAllTodoFailure()
}

class ToDoListPresenterImpl {
    var todos: [ToDo] = []
    
    weak var viewController: ToDoListPresenterToView?
    var interactor: ToDoListPresenterToInteractor?
    var router: ToDoListPresenterToRouter?
    
}

//MARK: - ToDoListViewToPresenter

extension ToDoListPresenterImpl: ToDoListViewToPresenter {
    func viewDidLoadHandler() {
        interactor?.fetchAllTodos()
    }
    
    func getAllTodos() -> [ToDo] {
        return todos
    }
    
    func didTapCell(id: Int) {
        todos[id].isCompleted.toggle()
        viewController?.reloadRow(at: id)
    }
    
    func createTodo() {
        //TODO: implement
    }
    
    func editTodo(id: Int) {
        //TODO: implement
    }
    
    func deleteTodo(id: Int) {
        //TODO: implement
    }
    
    func searchBy(text: String) {
        print("Search by " + text)
    }
}


// MARK: - ToDoListInterceptorToPresenter

extension ToDoListPresenterImpl: ToDoListInteractorToPresenter {
    func getAllTodoSuccess(todos: [ToDoEntity]) {
        self.todos = todos.map { todo in
            return ToDo(
                id: todo.id,
                title: getTitleFromDescription(todo.description),
                description: todo.description,
                isCompleted: todo.isCompleted,
                creationDate: .now
            )
        }
        viewController?.reloadTableView()
    }
    
    func getTitleFromDescription(_ description: String) -> String {
        let separatedTitle = description.split(separator: " ")
        switch separatedTitle.count {
        case 3...:
            return separatedTitle[0...2].joined(separator: " ")
        case 2...:
            return separatedTitle[0...1].joined(separator: " ")
        default:
            return "Untitled"
        }
    }
    
    func getAllTodoFailure() {
        
    }
    
    
}

