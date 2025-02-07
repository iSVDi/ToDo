//
//  ToDoListViewInput.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//


import UIKit
import TinyConstraints

protocol ToDoListViewInput: AnyObject {
    var navController: UINavigationController? { get }
    func reloadRow(at id: Int)
    func reloadTableView()
    func setupToolBarTitle(_ title: String)
}
