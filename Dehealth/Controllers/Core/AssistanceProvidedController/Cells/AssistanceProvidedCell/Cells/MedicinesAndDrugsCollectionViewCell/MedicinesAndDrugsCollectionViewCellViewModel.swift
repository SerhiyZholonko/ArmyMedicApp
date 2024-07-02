//
//  MedicinesAndDrugsCollectionViewCellViewModel.swift
//  Dehealth
//
//  Created by apple on 01.07.2024.
//

import Foundation


struct MedicinesAndDrugsCollectionViewCellViewModel {
     func getDateString(from isoDateString: String) -> String? {
        // Create a DateFormatter for the input ISO 8601 string
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        // Parse the input ISO 8601 string to a Date object
        guard let date = isoFormatter.date(from: isoDateString) else {
            return nil
        }

        // Create a DateFormatter for the desired output format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        return dateFormatter.string(from: date)
    }
    func convertToTimeString(from isoDateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Treat the input as GMT
        
        guard let date = formatter.date(from: isoDateString) else {
            return nil
        }
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Ensure the output is in GMT
        
        return timeFormatter.string(from: date)
    }
}
