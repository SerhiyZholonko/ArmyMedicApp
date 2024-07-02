//
//  DefenderModel.swift
//  Dehealth
//
//  Created by apple on 30.04.2024.
//

import Foundation


// MARK: - DefenderModel
struct DefenderModel: Codable {
    let requestID: JSONNull?
    let data: [SingleDefenderModel]
    let filteredTotal, total, taken, skipped: Int

    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case data, filteredTotal, total, taken, skipped
    }
}

// MARK: - Datum
struct SingleDefenderModel: Codable {
    let firstName, middleName, lastName: String
    let gender: Int
    let callSign: String
    let militaryRank, troopType: Int
    let subdivision, militaryUnitIdentifier, inn, identifier: String
    let photoURL: String
    let birthDate, allergiesAndContraindications: String

    enum CodingKeys: String, CodingKey {
        case firstName, middleName, lastName, gender, callSign, militaryRank, troopType, subdivision, militaryUnitIdentifier, inn, identifier
        case photoURL = "photoUrl"
        case birthDate, allergiesAndContraindications
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
