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
        let viewController = ToDoListViewControllerImpl()
        let presenter = ToDoListPresenterImpl()
        let interactor = ToDoListInteractorImpl()
        let router = ToDoListRouterImpl()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: viewController)
    }
    
}
