//
//  LogisticsReq.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import Foundation


struct LogisticsReq: Codable {
    let type: String
    let weightValue: Int
    let weightUnit: String
    let distanceValue: Int
    let distanceUnit: String
    let transportMethod: String
    
    enum CodingKeys: String, CodingKey{
        case type = "type"
        case weightValue = "weight_value"
        case weightUnit = "weight_unit"
        case distanceValue = "distance_value"
        case distanceUnit = "distance_unit"
        case transportMethod = "transport_method"
    }
}
