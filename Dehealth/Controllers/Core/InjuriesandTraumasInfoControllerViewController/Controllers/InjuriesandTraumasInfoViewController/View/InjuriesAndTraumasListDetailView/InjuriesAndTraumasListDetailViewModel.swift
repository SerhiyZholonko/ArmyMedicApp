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
        InjuriesAndTraumasModel(imageName: .accident, title: "ДТП", typeOfTransition: .none),
        InjuriesAndTraumasModel(imageName: .bluntTrauma, title: "Тупа травма", typeOfTransition: .none),
        InjuriesAndTraumasModel(imageName: .fall, title: "Падіння", typeOfTransition: .none)
    ]
    private let poisoningList: [InjuriesAndTraumasModel] = [
        InjuriesAndTraumasModel(imageName: .respiratoryTract, title: "Дихальних шляхів", typeOfTransition: .none),
        InjuriesAndTraumasModel(imageName: .lungs, title: "Легенів", typeOfTransition: .none),
        InjuriesAndTraumasModel(imageName: .stomach, title: "Шлунку", typeOfTransition: .none)
    ]

    init(type: InjuriesAndTraumasListDetailViewType) {
        self.type = type
    }
    
}
