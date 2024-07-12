//
//  InjuriesandTraumasInfoViewControllerViewModel.swift
//  Dehealth
//
//  Created by apple on 02.07.2024.
//

import UIKit


struct InjuriesandTraumasInfoViewControllerViewModel {
     //MARK: - Properties
    
    
    let colorsSetList: [String] = []
//var isPreliminaryDiagnosis = false
    var preliminaryDiagnosis: String = ""
    var colorsSetListIsEmpty: Bool {
       return colorsSetList.isEmpty
    }
    var tourniquetList: [Tourniquet] = []

    var tourniquetHeight: CGFloat {
        return CGFloat(tourniquetList.count * 103)
    }
    var isNotDiagnoseOrColorsOfMark: Bool {
        return preliminaryDiagnosis == "" && colorsSetList.isEmpty
    }
    var isColorEmpty: Bool {
        return colorsSetList.isEmpty
    }
     //MARK: - Functions
    
    mutating func addNewTourniquet(_ tourniquet: Tourniquet) {
        tourniquetList.append(tourniquet)
    }
    func getTourniquet(indexPath: IndexPath) -> Tourniquet {
        return tourniquetList[indexPath.item]
    }
    func calculateHeight( width: CGFloat) -> CGFloat {
        let tempTextView = UITextView()
        tempTextView.text = preliminaryDiagnosis
        tempTextView.font = UIFont.systemFont(ofSize: preliminaryDiagnosis == "" ? 0 : 16) // Make sure this matches your textView font
        tempTextView.frame.size = CGSize(width: width - (preliminaryDiagnosis == "" ? 0 : 32), height: CGFloat.greatestFiniteMagnitude) // Subtract padding
        let size = tempTextView.sizeThatFits(CGSize(width: width - (preliminaryDiagnosis == "" ? 0 : 32), height: CGFloat.greatestFiniteMagnitude))
        return size.height + (preliminaryDiagnosis == "" ? 0 : 32) + 24 // Add padding
      }
}
