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
struct InjuriesAndTraumasModel {
    let imageName: String
    let title: String
    var typeOfTransition: TypeOfTransition
}
struct InjuriesAndTraumasListViewModel {
     //MARK: - Properties
    let injuriesAndTraumasList: [InjuriesAndTraumasModel] = [
        InjuriesAndTraumasModel(imageName: "fragmentary", title: "Уламковий", typeOfTransition: .marksWithTheHelpOfGesture),
        InjuriesAndTraumasModel(imageName: "balloon", title: "Кульовий", typeOfTransition: .marksWithTheHelpOfGesture),
        InjuriesAndTraumasModel(imageName: "mine:IED", title: "Міна/СВП", typeOfTransition: .marksWithTheHelpOfGesture),
        InjuriesAndTraumasModel(imageName: "burns", title: "Опік", typeOfTransition: .burns),
        InjuriesAndTraumasModel(imageName: "percussion", title: "Ударний", typeOfTransition: .withSection),
        InjuriesAndTraumasModel(imageName: "amputation", title: "Ампутація", typeOfTransition: .marksWithTheHelpOfGesture),
        InjuriesAndTraumasModel(imageName: "headInjury", title: "Травма голови", typeOfTransition: .headInjury),
        InjuriesAndTraumasModel(imageName: "poisoning", title: "Отруєння", typeOfTransition: .withSection)
    ]
     //MARK: - Init
    
     //MARK: - Functions
    func getSizeInjuriesAndTraumasList() -> Int {
        return injuriesAndTraumasList.count
    }
    func getItem(by indexPath: IndexPath) ->  InjuriesAndTraumasModel? {
       guard indexPath.row <= injuriesAndTraumasList.count else { return nil }
        return injuriesAndTraumasList[indexPath.row]
    }
    
}
