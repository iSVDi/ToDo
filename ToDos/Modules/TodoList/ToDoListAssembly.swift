//
//  ToDoListAssembly.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//

import Foundation
import UIKit

final class ToDoListAssembly {
    
    static func getModule() -> UINavigationController {
        let viewController = ToDoListViewController()
        let presenter = ToDoListPresenter()
        let interactor = ToDoListInteractor()
        let router = ToDoListRouter()
        
        viewController.presenter = presenter
        presenter.viewInput = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
    
}
