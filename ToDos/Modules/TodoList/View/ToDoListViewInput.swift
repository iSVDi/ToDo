//
//  ToDoListViewInput.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//


import UIKit
import TinyConstraints

protocol ToDoListViewInput: AnyObject {
    func reloadRow(at id: Int)
    func reloadTableView()
}