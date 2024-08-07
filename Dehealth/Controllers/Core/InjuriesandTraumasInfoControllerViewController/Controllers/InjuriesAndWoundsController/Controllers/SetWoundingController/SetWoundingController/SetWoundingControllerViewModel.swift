//
//  SetWoundingControllerViewModel.swift
//  Dehealth
//
//  Created by apple on 02.08.2024.
//

import UIKit

protocol SetWoundingControllerViewModelDelegate: AnyObject {
    func viewModelDidUpdate(viewModel: SetWoundingControllerViewModel)
    func updateBottomView(woundListIsEmpty: Bool)
}

struct  SetWoundingControllerViewModel {
    weak var delegate: SetWoundingControllerViewModelDelegate?
      var woundList: [Wound] = [] {
        didSet {
            delegate?.updateBottomView(woundListIsEmpty: woundList.isEmpty)
        }
    }
    
    var imageName: ImageName?
     var image1Name: String = ""
    var isOnBackSide: Bool = false
    var x: Int = 0
    var y: Int = 0
    mutating func addItemToWoundList(_ item: Wound) {
        woundList.append(item)
        delegate?.viewModelDidUpdate(viewModel: self)
    }
    mutating func clearWoundList() {
        woundList = []
    }
    mutating func woundListRemoveLast() {
        if !self.woundList.isEmpty {
               self.woundList.removeLast()
           }
    }
    func getWoundList() -> [Wound] {
        return woundList
    }
    func woundListIsNotEmpty() -> Bool {
        return woundList.isEmpty
    }
    func getWound() -> Wound? {
        guard let imageName = self.imageName else { return nil }
        switch imageName {
        case .fragmentary:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 1, weaponType: 1)
        case .balloon:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 2, weaponType: 2)

        case .mine:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 3, weaponType: 3)

        case .burns:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 4, weaponType: 4)

        case .percussion:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y,type: 5, weaponType: 5)

        case .amputation:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 6, weaponType: 6)

        case .headInjury:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 7, weaponType: 7)

        case .poisoning:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 8, weaponType: 8)

        case .accident:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 9, weaponType: 9)

        case .bluntTrauma:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 10, weaponType: 10)

        case .fall:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 11, weaponType: 11)

        case .respiratoryTract:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 12, weaponType: 12)

        case .lungs:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 13, weaponType: 13)

        case .stomach:
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 14, weaponType: 14)
        }
    }
}
