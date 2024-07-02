//
//  StoreManager.swift
//  Dehealth
//
//  Created by apple on 29.04.2024.
//

import Foundation

enum StorageManagerKey: String {
    case accessToken
    case isSex
}

class StorageManager {
    static let shared = StorageManager()
    
    func save<T: Codable>(data: T, forKey key: StorageManagerKey) {
        UserDefaults.standard.set(encodable: data, forKey: key)
    }
    
    func load<T: Codable>(forKey key: StorageManagerKey) -> T? {
        guard let data: Data = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error decoding data for key \(key.rawValue): \(error)")
            return nil
        }
    }
    
    func delete(forKey key: StorageManagerKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: StorageManagerKey) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key.rawValue)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: StorageManagerKey) -> T? {
        if let data = object(forKey: key.rawValue) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
