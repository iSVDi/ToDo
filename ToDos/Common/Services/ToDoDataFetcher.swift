//
//  ToDoDataFetcher.swift
//  ToDos
//
//  Created by Daniil on 05.02.2025.
//

import Foundation
import Moya

enum ToDoDataFetcher {
    case getAllTodos
}

extension ToDoDataFetcher: TargetType {
    var baseURL: URL {
        return URL(string: "https://dummyjson.com/todos")!
    }
    
    var path: String {
        ""
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        [:]
    }
        
}


