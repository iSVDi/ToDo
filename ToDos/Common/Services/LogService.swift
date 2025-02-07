//
//  LogService.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//

import Foundation
import OSLog

class LogService {
    static private let logger = Logger()
    
    static func info(_ text: String) {
        logger.info("\(text)")
    }
    
    static func error(_ text: String) {
        logger.error("\(text)")
    }
    
    
}
