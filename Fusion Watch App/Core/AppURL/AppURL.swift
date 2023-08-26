//
//  AppURL.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import Foundation


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    // Add more HTTP methods as needed
}


enum Paths: String {
    case estimate = "/estimates"
    case createVehicle = "/vehicle_makes"
}

enum ApiKey: CustomStringConvertible {
    case apiKey
    var description: String {
        switch self {
        case .apiKey:
            return "fL1P0SMxpidl6FclW2ONWg"
        }
    }
}
