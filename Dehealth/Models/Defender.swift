//
//  Defender.swift
//  Dehealth
//
//  Created by apple on 28.06.2024.
//

import Foundation


import Foundation

struct Defender: Codable {
    let identifier: String
    let isDummyIdentifier: Bool
    let photoUrl: String
    let birthDate: String // Use Date if needed
    let allergiesAndContraindications: String
    let firstName: String
    let middleName: String
    let lastName: String
    let gender: Int
    let bloodType: Int
    let rhesusFactor: Int
    let callSign: String
    let militaryRank: Int
    let troopType: Int
    let subdivision: String
    let militaryUnitIdentifier: String
    let inn: String
}

struct MilitaryOperation: Codable {
    let identifier: String
    let time: String // Use Date if needed
}

struct EvacuationTarget: Codable {
    let identifier: String
    let stage: Int
    let id: String
    let supervisorUserId: String
    let militaryUnitIdentifier: String
}

struct Medic: Codable {
    let identifier: String
    let userId: String
    let medicalUnitIdentifier: String
    let isSupervisor: Bool
}

struct EvacuationStage: Codable {
    let evacuationTarget: EvacuationTarget
    let medic: Medic
}

struct EvacuationConditions: Codable {
    let priority: Int
    let position: Int
    let transportType: Int
}

struct File: Codable {
    let createdAt: String // Use Date if needed
    let url: String
    let type: Int
}

//struct Wound: Codable {
//    let isOnBackSide: Bool
//    let x: Int
//    let y: Int
//    let type: Int
//    let weaponType: Int
//}
//struct Wound: Codable {
//    let isOnBackSide: Bool
//    let x: Int
//    let y: Int
//    let type: Int
//    let weaponType: Int
//
//    // Function to retrieve the corresponding InjuriesAndTraumasModel
//    func getInjuriesAndTraumasModel() -> InjuriesAndTraumasModel? {
//        guard let imageName = ImageName.from(type: type) else {
//            return nil
//        }
//
//        // Provide a default WhatPicture and TypeOfTransition if needed
//        let defaultWhatPicture: WhatPicture? = nil
//        let defaultTypeOfTransition = TypeOfTransition.someDefault // Replace with an actual default
//
//        return InjuriesAndTraumasModel(
//            whatPicture: defaultWhatPicture,
//            imageName: imageName,
//            title: imageName.title,
//            typeOfTransition: defaultTypeOfTransition
//        )
//    }
//}
struct Wound: Codable, Equatable {
    let isOnBackSide: Bool
    let x: Int
    let y: Int
    let type: Int
    let weaponType: Int

 
    func getInjuriesAndTraumasModel() -> InjuriesAndTraumasModel? {
        guard let imageName = ImageName.from(type: type) else {
            return nil
        }

        let defaultWhatPicture: WhatPicture? = nil
        let defaultTypeOfTransition = TypeOfTransition.none

        return InjuriesAndTraumasModel(
            whatPicture: defaultWhatPicture,
            imageName: imageName,
            title: imageName.title,
            typeOfTransition: defaultTypeOfTransition
        )
    }

    static func == (lhs: Wound, rhs: Wound) -> Bool {
        return lhs.x == rhs.x &&
               lhs.y == rhs.y &&
               lhs.type == rhs.type &&
               lhs.isOnBackSide == rhs.isOnBackSide &&
               lhs.weaponType == rhs.weaponType
    }
}
struct Trauma: Codable {
    let isOnBackSide: Bool
    let x: Int
    let y: Int
    let type: Int
    let burnType: Int
    let poisonType: Int
    let weaponType: Int
}

struct Tourniquet: Codable {
    let limb: Int
    let type: Int
    let customType: String
    let method: Int
    let state: Int
    let appliedAt: String // Use Date if needed
    let releasedAt: String // Use Date if needed
}

enum StateSegment1: Int, CaseIterable {
    case leftHand = 0
    case rightHand
    case leftLeg
    case rightLeg
    
    var title: String {
        switch self {
        case .leftHand: return "Ліва рука"
        case .rightHand: return "Права рука"
        case .leftLeg: return "Ліва нога"
        case .rightLeg: return "Права нога"
        }
    }
}
enum StateSegment2: Int, CaseIterable {
    case leftHand = 0
    case rightHand
    case leftAnrRight
    
    var title: String {
        switch self {
        case .leftHand: return "Ліва"
        case .rightHand: return "Права"
        case .leftAnrRight: return "Ліва та права"
        }
    }
}
enum StateSegment3: Int, CaseIterable {
    case leftHand = 0
  
    
    var title: String {
        switch self {
        case .leftHand: return "Живіт"
        }
    }
}
enum BodyPlace: Int, CaseIterable {
    case limbs = 0
    case knotty
    case abdominal
    
    var title: String {
        switch self {
        case .limbs: return "Для кінцівок"
        case .knotty: return "Вузловий"
        case .abdominal: return "Абдомінальний"
        }
    }
}
enum TourniquetTypeState1: Int, CaseIterable {
    case cat7 = 0
    case soft
    case samxt
    case tmt
    case sich
    case dnipro
    case custom
    
    var title: String {
        switch self {
        case .cat7: return "CAT 7"
        case .soft: return "SOF-T"
        case .samxt: return "SAM-XT"
        case .tmt: return "TMT"
        case .sich: return "SICH"
        case .dnipro: return "Dnipro"
        case .custom: return "Вказати свій варіант"
        }
    }
  
  
}
enum TourniquetTypeState3: Int, CaseIterable {
    case aajtS = 0
    case croC
    case custom
    
    var title: String {
        switch self {
        case .aajtS: return "AAJT-S"
        case .croC: return "CRoC"
        case .custom: return "Вказати свій варіант"
        }
    }
  
  
}

enum TourniquetTypeState2: Int, CaseIterable {
    case samJt = 0
    case aajtS
    case cRoc
    case jett
    case custom
    
    var title: String {
        switch self {
        case .samJt: return "SAM JT"
        case .aajtS: return "AAJT-S"
        case .cRoc: return "CRoC"
        case .jett: return "JETT"
        case .custom: return "Вказати свій варіант"
       
        }
    }
  
  
}
struct HealthCheck: Codable {
    let madeAt: String // Use Date if needed
    let pulse: Int
    let arterialPressure: ArterialPressure
    let breathingRate: Int
    let saturation: Int
    let consciousnessLevel: Int
    let painLevel: Int
}

struct ArterialPressure: Codable {
    let diastolic: Int
    let systolic: Int
}

struct Aid: Codable {
    let tourniquet: TourniquetAid
    let swab: SwabAid
    let bandage: BandageAid
    let breathingRecoveryDevices: BreathingRecoveryDevicesAid
    let breathing: BreathingAid
    let trauma: TraumaAid
    let otherAids: [Int]
    let circulation: CirculationAid
}

struct TourniquetAid: Codable {
    let methods: [Int]
    let type: Int
    let customType: String
}

struct SwabAid: Codable {
    let type: Int
    let customType: String
    let methods: [Int]
}

struct BandageAid: Codable {
    let methods: [Int]
    let notes: String
}

struct BreathingRecoveryDevicesAid: Codable {
    let methods: [Int]
    let notes: String
}

struct BreathingAid: Codable {
    let methods: [Int]
    let intercostalSpace: IntercostalSpace
    let drainage: Drainage
}

struct IntercostalSpace: Codable {
    let secondTime: String // Use Date if needed
    let secondTypes: [Int]
    let fifthTime: String // Use Date if needed
    let fifthTypes: [Int]
}

struct Drainage: Codable {
    let locationTime: String // Use Date if needed
    let locationTypes: [Int]
    let contentTime: String // Use Date if needed
    let contentTypes: [Int]
}

struct TraumaAid: Codable {
    let methods: [Int]
    let notes: String
    let heatingNote: String
}

struct CirculationAid: Codable {
    let methods: [Int]
    let intraosseousAccess: IntraosseousAccess
    let intravenousAccess: IntravenousAccess
    let fixationType: Int
    let customFixationType: String
    let eFast: String
}

struct IntraosseousAccess: Codable {
    let methods: [Int]
}

struct IntravenousAccess: Codable {
    let methods: [Int]
    let customMethod: String
}

struct Medicine: Codable {
    let madeAt: String // Use Date if needed
    let createAt: String // Use Date if needed
    let name: String
    let amount: Int
    let method: Int
    let customMethod: String
    let measureType: Int
    let customMeasure: String
}

struct MainModel: Codable {
    let defender: Defender
    let militaryOperation: MilitaryOperation
    let evacuationTargetIdentifier: String
    let evacuationStages: [EvacuationStage]
    let evacuationConditions: EvacuationConditions
    let files: [File]
    let wounds: [Wound]
    let traumas: [Trauma]
    let tourniquets: [Tourniquet]
    let healthChecks: [HealthCheck]
    let aid: Aid
    let medicines: [Medicine]
    let medicName: String
    let note: String
    let preliminaryDiagnosis: String
    let defenderStatus: Int
}
