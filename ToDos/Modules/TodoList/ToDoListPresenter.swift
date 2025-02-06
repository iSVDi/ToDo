//
//  ToDoListPresenter.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation

final class ToDoListPresenter {
    weak var viewController: ToDoListViewInput?
    var interactor: ToDoListInteractorInput?
    var router: ToDoListRouterInput?
    
    private let userDataService = UserDataService()
    private var todos: [ToDo] = []
    private var searchQuery: String = ""
}

//MARK: - Helpers

private extension ToDoListPresenter {
    func getFilteredTodos() -> [ToDo] {
        guard !searchQuery.isEmpty else { return todos }
        return todos.filter {
            $0.description.lowercased().contains(searchQuery) || $0.description.lowercased().contains(searchQuery)
        }
    }
    
}

//MARK: - ToDoListViewToOutput

extension ToDoListPresenter: ToDoListViewOutput {
    func viewDidLoadHandler() {
        guard userDataService.isFirstLaunch else {
            interactor?.fetchAllTodosFromStore()
            return
        }
        interactor?.fetchAllTodos()
        userDataService.isFirstLaunch = false
    }
    
    func getAllTodos() -> [ToDo] {
        guard !searchQuery.isEmpty else { return todos }
        return getFilteredTodos()
    }
    
    func didTapCell(cellId: Int) {
        let filteredTodos = getFilteredTodos()
        let id = filteredTodos[cellId].id
        guard let arrIndex = todos.firstIndex(where: { $0.id == id}) else { return }
        todos[arrIndex].isCompleted.toggle()
        interactor?.updateToDoState(id: id)
        viewController?.reloadRow(at: cellId)
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
        searchQuery = text.lowercased()
        viewController?.reloadTableView()
    }
}


// MARK: - ToDoListInterceptorToPresenter

extension ToDoListPresenter: ToDoListInteractorOutput {
    func getAllTodoSuccess(_ todos: [ToDoEntity]) {
        todos.forEach { entity in
            let todo = ToDo(
                id: entity.id,
                title: getTitleFromDescription(entity.description),
                description: entity.description,
                isCompleted: entity.isCompleted,
                creationDate: .now
            )
            self.todos.append(todo)
            
            let todoModel = DataManager.createTodoModel()
            todoModel.id = todo.id
            todoModel.details = todo.description
            todoModel.title = todo.title
            todoModel.isCompleted = todo.isCompleted
            todoModel.creationDate = todo.creationDate
        }
        DataManager.save()
        viewController?.reloadTableView()
    }
    
    func getAllCoreDataTodoSuccess(_ todos: [ToDo]) {
        self.todos = todos
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
        //TODO: implement TODO
    }
    
    
}

