//
//  ToDoDetailsViewOutput.swift
//  ToDos
//
//  Created by Daniil on 07.02.2025.
//


import Foundation

protocol ToDoDetailsViewOutput: AnyObject {
    
    func viewDidLoadHandler()
    //update todo
    func viewWillDisapearHandler()
    
}
