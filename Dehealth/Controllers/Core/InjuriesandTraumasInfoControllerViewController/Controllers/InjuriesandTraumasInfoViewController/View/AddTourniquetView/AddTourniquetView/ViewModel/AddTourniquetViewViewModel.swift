//
//  AddTourniquetViewViewModel.swift
//  Dehealth
//
//  Created by apple on 08.07.2024.
//

import Foundation



struct AddTourniquetViewViewModel {
    var isTypeOfTurnstile: Bool = false
    var method: Int = 0
    var state: Int = 0
    var limb: Int?
    //heand or legs
    var type: Int?
    var appliedAt = ""
    var releasedAt = ""
    var customType: String = ""
    var typeOfTurnstile: String = "CAT 7"
    var overlayTypeTurnstile: String = ""
    var time: String?
    let typeOfTurnstileList: [String] = ["CAT 7", "SOF-T", "SAM-XT", "TMT", "SICH", "Dnipro", "Вказати свій варіант"]
     //MARK: - Functions
    
    mutating func getTurnstileForSave() -> Tourniquet? {
        guard validation() else { return nil }
        if let time = time {
            appliedAt = convertToISO8601(timeString: time) ?? ""
        } else {
            return nil
        }
        releasedAt = createReleasedTime()
        return Tourniquet(limb: limb!, type: type!, customType: customType, method: method, state: state, appliedAt: appliedAt, releasedAt: releasedAt)
    }
    private func createReleasedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    func convertToISO8601(timeString: String) -> String? {
        // Create a DateFormatter to parse the "HH:mm" time string
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "HH:mm"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Create a Date object from the time string
        guard let timeDate = inputDateFormatter.date(from: timeString) else {
            return nil
        }
        
        // Create another DateFormatter to format the Date object to "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        outputDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Get the current date
        let currentDate = Date()
        
        // Extract the current date components (year, month, day)
        let calendar = Calendar.current
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        // Create a new date by combining the current date components with the parsed time
        var combinedComponents = calendar.dateComponents([.hour, .minute], from: timeDate)
        combinedComponents.year = currentComponents.year
        combinedComponents.month = currentComponents.month
        combinedComponents.day = currentComponents.day
        
        // Create the combined date
        guard let combinedDate = calendar.date(from: combinedComponents) else {
            return nil
        }
        
        // Format the combined date to the desired string
        return outputDateFormatter.string(from: combinedDate)
    }
    private func validation() -> Bool {
//        guard method != nil else { return false }
        guard state != nil else {return false}
        guard limb != nil else {return false}
        guard type != nil else {return false}
        return true
    }
    mutating func getIndex(_ indexPath: IndexPath){
        let item = typeOfTurnstileList[indexPath.item]
        if let index = typeOfTurnstileList.firstIndex(of: "SAM-XT") {
            print("The index of SAM-XT is \(index)")
            self.type = index
        } else {
            print("SAM-XT is not found in the array")
        }
    }
}

