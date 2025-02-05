//
//  ToDoListPresenter.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation


protocol ToDoListPresenter {
    func getAllToDos() -> [ToDo]
    func didTapCell(id: Int)
    func createToDo()
    func editToDo(id: Int)
    func deleteToDo(id: Int)
    func searchBy(text: String)
}

class ToDoListPresenterImpl: ToDoListPresenter {
    private let mockToDos: [ToDo] = [
        .init(
            id: 1,
            title: "Do something nice",
            description: "description cool and really, really really ",
            isCompleted: false,
            creationDate: .now
        ),
        .init(
            id: 2,
            title: "Memorize a poem",
            description: "description cool and really, really really really really really really really really really really really really really really really really really really really really really  long",
            isCompleted: true,
            creationDate: .now
        ),
        .init(
            id: 3,
            title: "Watch a classic movie",
            description: "description cool and really, really really really really really really really really really really really really really really really really really really really really really  long",
            isCompleted: true,
            creationDate: .now
        )
    ]
    
    
    func getAllToDos() -> [ToDo] {
        return mockToDos
    }
    
    func didTapCell(id: Int) {
        print("Tapped cell with id \(id)")
    }
    
    func createToDo() {
        
    }
    
    func editToDo(id: Int) {
        
    }
    
    func deleteToDo(id: Int) {
        
    }
    
    func searchBy(text: String) {
        print("Search by " + text)
    }

    
}



