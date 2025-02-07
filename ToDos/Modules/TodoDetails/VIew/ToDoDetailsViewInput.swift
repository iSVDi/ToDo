//
//  ToDoDetailsViewInput.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//


import Foundation
import UIKit

protocol ToDoDetailsViewInput: AnyObject {
    func disableUserInteraction()
    func setupData(todo: ToDo)
}
