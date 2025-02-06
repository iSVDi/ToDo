//
//  ToDoListRouterImpl.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import UIKit

protocol ToDoListPresenterToRouter: AnyObject {
    func push(vc: UIViewController, from navController: UINavigationController)
}

final class ToDoListRouterImpl: ToDoListPresenterToRouter {
    
    func push(vc: UIViewController, from navController: UINavigationController) {
        navController.pushViewController(vc, animated: true)
    }

}


