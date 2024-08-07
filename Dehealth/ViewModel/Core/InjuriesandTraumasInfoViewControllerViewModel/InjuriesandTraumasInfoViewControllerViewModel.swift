//
//  InjuriesandTraumasInfoViewControllerViewModel.swift
//  Dehealth
//
//  Created by apple on 02.07.2024.
//

import UIKit



struct InjuriesandTraumasInfoViewControllerViewModel {
     //MARK: - Properties
    // selected wound
    var woundList: [Wound] = []
    //TODO: item if update woundList
    var markedInjuriesandTraumasList: [InjuriesAndTraumasModel] = []
//    let colorsSetList: [String] = []
    var preliminaryDiagnosis: String = ""
   
    var tourniquetList: [Tourniquet] = []
    var isHeadImageOnFront: Bool = false
    var tourniquetHeight: CGFloat {
        return CGFloat(tourniquetList.count * 103)
    }
    var colorsSetListIsEmpty: Bool {
       return markedInjuriesandTraumasList.isEmpty
    }
    var isNotDiagnose: Bool {
        return preliminaryDiagnosis == ""
    }
    var isColorEmpty: Bool {
        return markedInjuriesandTraumasList.isEmpty
    }
     //MARK: - Functions
    
    mutating func addNewTourniquet(_ tourniquet: Tourniquet) {
        tourniquetList.append(tourniquet)
    }
    mutating func addNewItemInmarkedInjuriesandTraumasList(item: InjuriesAndTraumasModel) {
        if !self.markedInjuriesandTraumasList.contains(where: { $0 == item }) {
            self.markedInjuriesandTraumasList.append(item)
        }
    }
    mutating func deleteItemFromColorList(model: InjuriesAndTraumasModel) {
       //TODO: - Remove item from color view
        let wound = model.getWound(isOnBackSide: true, x: 1, y: 1)
        let type = wound.type
        woundList.removeAll { item in
            item.type == type
        }
        markedInjuriesandTraumasList.removeAll { $0 == model }
        
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
