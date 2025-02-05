//
//  ToDo.swift
//  ToDos
//
//  Created by Daniil on 03.02.2025.
//

import Foundation

struct ToDo: Codable {
    let id: Int
    let title: String
    let description: String
    var isCompleted: Bool
    let creationDate: Date
}
