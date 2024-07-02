//
//  AddThePreparationViewViewModel.swift
//  Dehealth
//
//  Created by apple on 28.06.2024.
//

import Foundation

struct AddThePreparationViewViewModel {
    var time = ""
    var volume = ""
    var name = ""
    var customMethod = ""
    var medicine: Medicine?
    
     func getMedicine() ->  Medicine? {
        guard validationIsEmpty() else { return nil }
        guard let madeAt = convertToISO8601(timeString: time) else { return nil }
         print(madeAt)
        let createAt = getCurrentTimeString()
        return Medicine(madeAt: madeAt, createAt: createAt, name: name, amount: Int(volume) ?? 0, method: 1, customMethod: customMethod, measureType: 1, customMeasure: "мг")
    }
    private func validationIsEmpty() -> Bool {
        guard time != "", volume != "", name != "", customMethod != "" else {return false}
        return true
    }
    private func getCurrentTimeString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    func convertToISO8601(timeString: String, currentDate: Date = Date()) -> String? {
        // Create a DateFormatter for the input time string
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Treat the input as GMT
        
        // Parse the input time string to a Date object
        guard let timeDate = timeFormatter.date(from: timeString) else {
            return nil
        }
        
        // Combine the current date with the parsed time
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)! // Ensure the calendar is in GMT
        
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: timeDate)
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        dateComponents.second = 0
        dateComponents.nanosecond = 0
        
        // Create the combined date
        guard let combinedDate = calendar.date(from: dateComponents) else {
            return nil
        }
        
        // Create a DateFormatter for the desired output format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        // Format the combined date to the desired output format
        let formattedDate = outputFormatter.string(from: combinedDate)
        
        return formattedDate
    }
//    func convertToTimeString(from isoDateString: String) -> String? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Treat the input as GMT
//        
//        guard let date = formatter.date(from: isoDateString) else {
//            return nil
//        }
//        
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = "HH:mm"
//        timeFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Ensure the output is in GMT
//        return timeFormatter.string(from: date)
//    }
}
