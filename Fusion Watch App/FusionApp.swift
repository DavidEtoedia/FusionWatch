//
//  FusionApp.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import SwiftUI

@main
struct Fusion_Watch_AppApp: App {
    init(){
        initServiceContainer()
    }
    var body: some Scene {
        WindowGroup {
             Home()
                .environmentObject(SupbaseViewModel())
                .environmentObject(EnergyViewModel())
                .environmentObject(FlightViewModel())
                .environmentObject(ShipViewModel())
        }
    }
}


func initServiceContainer(){
    
    ServiceContainer.register(type: URLSession.self, .shared)
    ServiceContainer.register(type: NetworkServiceManager.self, NetworkService())
    ServiceContainer.register(type: SupaBaseManager.self, SupaBaseService())
    
    // Repositories
    ServiceContainer.register(type: HttpRepository.self, HttpRepositoryImp())
    ServiceContainer.register(type: SupaBaseRepository.self, SupaBaseRepoImpl())
    
}
