//
//  ToDoEntity.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//


import Foundation
import Moya

struct ToDoBunch: Codable {
    let todos: [ToDoEntity]
}

struct ToDoEntity: Codable {
    let id: Int
    let description: String
    let isCompleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "todo"
        case isCompleted = "completed"
    }
}
