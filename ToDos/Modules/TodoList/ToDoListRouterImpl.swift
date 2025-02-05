//
//  ToDoListRouterImpl.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import UIKit

protocol ToDoListPresenterToRouter: AnyObject {
    static func getModule() -> UINavigationController
    func pushFrom(vc: UIViewController, from navController: UINavigationController)
}

class ToDoListRouterImpl: ToDoListPresenterToRouter {
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
        
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func pushFrom(vc: UIViewController, from navController: UINavigationController) {
        navController.pushViewController(vc, animated: true)
    }

}
