//
//  TokenManager.swift
//  Dehealth
//
//  Created by apple on 15.05.2024.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
     func tokenNeedsUpdate() -> Bool {
        // Retrieve the last update date from UserDefaults
        if let lastUpdateDate = UserDefaults.standard.object(forKey: "lastTokenUpdateDate") as? Date {
            // Calculate the time interval between the last update date and now
            let currentDate = Date()
            let timeIntervalSinceLastUpdate = currentDate.timeIntervalSince(lastUpdateDate)
            
            // Check if more than 24 hours (86400 seconds) have passed since the last update
            if timeIntervalSinceLastUpdate >= 86400 {
                // Update the last update date in UserDefaults
                UserDefaults.standard.set(currentDate, forKey: "lastTokenUpdateDate")
                return true
            } else {
                return false
            }
        } else {
            // If there's no last update date stored, update the token
            let currentDate = Date()
            UserDefaults.standard.set(currentDate, forKey: "lastTokenUpdateDate")
            return true
        }
    }
     func saveLastUpdateDate() {
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: "lastTokenUpdateDate")
    }
}
