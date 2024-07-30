//
//  AddTourniquetViewViewModel.swift
//  Dehealth
//
//  Created by apple on 08.07.2024.
//

import Foundation



struct AddTourniquetViewViewModel {
    var isTypeOfTurnstileForLimbs: Bool = false
    var isTypeOfTurnstileForNodal: Bool = false
    var isTypeOfTurnstileForAbdominal: Bool = false
    var selectedIndex: IndexPath?

    var method: Int = 0
    var state: Int = 0
    var limb: Int? //кінцівка, heand or legs
    var type: Int?
    var appliedAt = ""
    var releasedAt = ""
    var customType: String = ""
    var typeOfTurnstile: String = "CAT 7"
    var overlayTypeTurnstile: String = ""
    var time: String?
    let typeOfTurnstileListForLimbs: [String] = ["CAT 7", "SOF-T", "SAM-XT", "TMT", "SICH", "Dnipro", "Вказати свій варіант"]
    let typeOfTurnstileListForNodal: [String] = ["SAM JT", "AAJT-S", "CRoC", "JETT", "Вказати свій варіант"]
    let typeOfTurnstileListForAbdominal: [String] = ["AAJT-S", "CRoC", "Вказати свій варіант"]

     //MARK: - Functions
    mutating func updateData() {
        self.limb = nil
        self.time = nil
        self.type = nil
        
    }
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
//        guard state != nil else {return false}
      //limb == nil
        guard limb != nil else {return false}
        guard type != nil else {return false}
        return true
    }
    mutating func getIndex(_ indexPath: IndexPath){
        if isTypeOfTurnstileForLimbs {
            let item = typeOfTurnstileListForLimbs[indexPath.item]
            if let index = typeOfTurnstileListForLimbs.firstIndex(of: item) {
                self.type = index
                print("\(index), \(typeOfTurnstileListForLimbs[indexPath.item])")
            } else {
                print("\(item) is not found in the array")
            }
        } else if isTypeOfTurnstileForNodal {
            let item = typeOfTurnstileListForNodal[indexPath.item]
            if let index = typeOfTurnstileListForNodal.firstIndex(of: item) {
                print("\(index), \(item)")
                self.type = index
            } else {
                print("\(item) is not found in the array")
            }
        } else if isTypeOfTurnstileForAbdominal {
            let item = typeOfTurnstileListForAbdominal[indexPath.item]
            if let index = typeOfTurnstileListForAbdominal.firstIndex(of: item) {
                self.type = index
            } else {
                print("\(item) is not found in the array")
            }
        }
    }
}

