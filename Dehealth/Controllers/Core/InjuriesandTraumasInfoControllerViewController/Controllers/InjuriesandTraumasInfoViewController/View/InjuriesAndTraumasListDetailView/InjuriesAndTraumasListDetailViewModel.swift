//
//  InjuriesAndTraumasListDetailViewModel.swift
//  Dehealth
//
//  Created by apple on 25.07.2024.
//

import Foundation
enum InjuriesAndTraumasListDetailViewType {
    case percussion
    case poisoning
}
struct InjuriesAndTraumasListDetailViewModel {
    var currentList: [InjuriesAndTraumasModel] {
            switch type {
            case .percussion:
                return percussionList
            case .poisoning:
                return poisoningList
            }
        }
        
        var countForList: Int {
            return currentList.count
        }
    private let type: InjuriesAndTraumasListDetailViewType
    private let percussionList: [InjuriesAndTraumasModel] = [
        InjuriesAndTraumasModel(imageName: "ACCIDENT", title: "ДТП", typeOfTransition: .none),
        InjuriesAndTraumasModel(imageName: "BluntTrauma", title: "Тупа травма", typeOfTransition: .none),
        InjuriesAndTraumasModel(imageName: "Fall", title: "Падіння", typeOfTransition: .none)
    ]
    private let poisoningList: [InjuriesAndTraumasModel] = [
        InjuriesAndTraumasModel(imageName: "RespiratoryTract", title: "Дихальних шляхів", typeOfTransition: .none),
        InjuriesAndTraumasModel(imageName: "Lungs", title: "Легенів", typeOfTransition: .none),
        InjuriesAndTraumasModel(imageName: "Stomach", title: "Шлунку", typeOfTransition: .none)
    ]

    init(type: InjuriesAndTraumasListDetailViewType) {
        self.type = type
    }
    
}
