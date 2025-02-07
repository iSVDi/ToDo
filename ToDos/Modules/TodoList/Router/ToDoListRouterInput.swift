//
//  ToDoListRouterInput.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//


import Foundation
import UIKit

protocol ToDoListRouterInput: AnyObject {
    func pushToTodoDetails(from navController: UINavigationController?, with state: ToDoState)
}
