//
//  FlightReq.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import Foundation


// MARK: - FlightReq
struct FlightReq: Codable {
    let type: String
    let passengers: Int
    let legs: [LegReq]
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case passengers = "passengers"
        case legs = "legs"
    }
}

// MARK: - Leg
struct LegReq: Codable {
    let departureAirport: String
    let destinationAirport: String

    enum CodingKeys: String, CodingKey {
        case departureAirport = "departure_airport"
        case destinationAirport = "destination_airport"
    }
}
