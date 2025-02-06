//
//  ToDoListRouter.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import UIKit

final class ToDoListRouter: ToDoListRouterInput {
    
    func push(vc: UIViewController, from navController: UINavigationController) {
        navController.pushViewController(vc, animated: true)
    }
    
}


