//
//  InjuriesAndTraumasListViewModel.swift
//  Dehealth
//
//  Created by apple on 22.07.2024.
//

import Foundation
enum TypeOfTransition {
    case withSection
    case burns
    case headInjury
    case marksWithTheHelpOfGesture
    case none
}
enum WhatPicture {
    case front
    case back
}
enum ImageName: String {
    case fragmentary = "fragmentary"
    case balloon = "balloon"
    case mine = "mine:IED"
    case burns = "burns"
    case percussion = "percussion"
    case amputation = "amputation"
    case headInjury = "headInjury"
    case poisoning = "poisoning"
    case accident = "ACCIDENT"
    case bluntTrauma = "BluntTrauma"
    case fall = "Fall"
    case respiratoryTract = "RespiratoryTract"
    case lungs = "Lungs"
    case stomach = "Stomach"

    var title: String {
        switch self {
        case .fragmentary:
            return "Уламковий"
        case .balloon:
            return "Кульовий"
        case .mine:
            return "Міна/СВП"
        case .burns:
            return "Опік"
        case .percussion:
            return "Ударний"
        case .amputation:
            return "Ампутація"
        case .headInjury:
            return "Травма голови"
        case .poisoning:
            return "Отруєння"
        case .accident:
            return "ДТП"
        case .bluntTrauma:
            return "Тупа травма"
        case .fall:
            return "Падіння"
        case .respiratoryTract:
            return "Дихальних шляхів"
        case .lungs:
            return "Легенів"
        case .stomach:
            return "Шлунку"
        }
    }

    // Mapping Int to ImageName
    static func from(type: Int) -> ImageName? {
        switch type {
        case 1: return .fragmentary
        case 2: return .balloon
        case 3: return .mine
        case 4: return .burns
        case 5: return .percussion
        case 6: return .amputation
        case 7: return .headInjury
        case 8: return .poisoning
        case 9: return .accident
        case 10: return .bluntTrauma
        case 11: return .fall
        case 12: return .respiratoryTract
        case 13: return .lungs
        case 14: return .stomach
        default: return nil
        }
    }
}
struct InjuriesAndTraumasModel: Equatable {
    var whatPicture: WhatPicture?
    let imageName: ImageName
    let title: String
    var typeOfTransition: TypeOfTransition

    func getWound(isOnBackSide: Bool, x: Int, y: Int) -> Wound {
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
            return Wound(isOnBackSide: isOnBackSide, x: x, y: y, type: 5, weaponType: 5)
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
    func getType() -> Int {
       switch imageName{
       case .fragmentary:
           return 1
       case .balloon:
           return 2
       case .mine:
           return 3
       case .burns:
           return 4
       case .percussion:
           return 5
       case .amputation:
           return 6
       case .headInjury:
           return 7
       case .poisoning:
           return 8
       case .accident:
           return 9
       case .bluntTrauma:
           return 10
       case .fall:
           return 11
       case .respiratoryTract:
           return 12
       case .lungs:
           return 13
       case .stomach:
           return 14
       }
    }
    static func ==(lhs: InjuriesAndTraumasModel, rhs: InjuriesAndTraumasModel) -> Bool {
        return lhs.imageName == rhs.imageName &&
               lhs.title == rhs.title &&
               lhs.typeOfTransition == rhs.typeOfTransition
    }
}

struct InjuriesAndTraumasListViewModel {
     //MARK: - Properties
    private var selectedInjuriesAndTraumasList: [InjuriesAndTraumasModel] = []
    lazy var injuriesAndTraumasList = injuriesAndTraumasListAll.filter { injury in
        !selectedInjuriesAndTraumasList.contains(where: { $0 == injury })
    }
    let injuriesAndTraumasListAll: [InjuriesAndTraumasModel] = [
        InjuriesAndTraumasModel(imageName: .fragmentary, title: ImageName.fragmentary.title, typeOfTransition: .marksWithTheHelpOfGesture),
        InjuriesAndTraumasModel(imageName: .balloon, title: ImageName.balloon.title, typeOfTransition: .marksWithTheHelpOfGesture),
        InjuriesAndTraumasModel(imageName: .mine, title: ImageName.mine.rawValue, typeOfTransition: .marksWithTheHelpOfGesture),
        InjuriesAndTraumasModel(imageName: .burns, title: ImageName.burns.title, typeOfTransition: .burns),
        InjuriesAndTraumasModel(imageName: .percussion, title: ImageName.percussion.title, typeOfTransition: .withSection),
        InjuriesAndTraumasModel(imageName: .amputation, title: ImageName.amputation.title, typeOfTransition: .marksWithTheHelpOfGesture),
        InjuriesAndTraumasModel(imageName: .headInjury, title: ImageName.headInjury.title, typeOfTransition: .headInjury),
        InjuriesAndTraumasModel(imageName: .poisoning, title: ImageName.poisoning.title, typeOfTransition: .withSection)
    ]
     //MARK: - Init
    init(selectedInjuriesAndTraumasList: [InjuriesAndTraumasModel]) {
        self.selectedInjuriesAndTraumasList = selectedInjuriesAndTraumasList
    }
     //MARK: - Functions
    mutating func getSizeInjuriesAndTraumasList() -> Int {
        return injuriesAndTraumasList.count
    }
    mutating func getItem(by indexPath: IndexPath) ->  InjuriesAndTraumasModel? {
       guard indexPath.row <= injuriesAndTraumasList.count else { return nil }
        return injuriesAndTraumasList[indexPath.row]
    }
    
}
