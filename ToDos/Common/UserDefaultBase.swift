//
//  UserDefaultBase.swift
//  ToDos
//
//  Created by Daniil on 06.02.2025.
//


import Foundation

class UserDefaultBase<Key: RawRepresentable> where Key.RawValue == String {
    private let standard = UserDefaults.standard
    
    func setBool(value: Bool, key: Key) {
        standard.set(value, forKey: key.rawValue)
    }
    
    func getBool(for key: Key) -> Bool {
        standard.bool(forKey: key.rawValue)
    }
}
