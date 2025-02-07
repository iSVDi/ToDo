//
//  ToDoListRouter.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import UIKit

final class ToDoListRouter: ToDoListRouterInput {
    func pushToTodoDetails(from navController: UINavigationController?) {
        let vc = ToDoDetailsAssembly.getModule()
        navController?.pushViewController(vc, animated: true)
    }
}


