//
//  ToDoDetailsAssembly.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//

import UIKit

enum ToDoState {
    case edit(_ todoId: Int32)
    case create
}

class ToDoDetailsAssembly {
    
    static func getModule(with state: ToDoState) -> UIViewController {
        let viewController = ToDoDetailsViewController()
        let presenter = ToDoDetailsPresenter(todoState: state)
        let interactor = ToDoDetailsInteractor()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        presenter.viewInput = viewController
        presenter.interactor = interactor
        
        return viewController
    }
    
}
