//
//  ToDoListRouterInput.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//


import Foundation
import UIKit

protocol ToDoListRouterInput: AnyObject {
    func push(vc: UIViewController, from navController: UINavigationController)
}