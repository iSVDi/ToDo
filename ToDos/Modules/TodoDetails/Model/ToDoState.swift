//
//  ToDoState.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//


import UIKit

enum ToDoState {
    case edit(_ todoId: Int32)
    case create
}