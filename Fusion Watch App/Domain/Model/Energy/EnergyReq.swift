//
//  EnergyReq.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import Foundation


// MARK: - EnergyReq
struct EnergyReq: Codable {
    let type, electricityUnit: String
    let electricityValue: Int
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case type
        case electricityUnit = "electricity_unit"
        case electricityValue = "electricity_value"
        case country, state
    }
}
