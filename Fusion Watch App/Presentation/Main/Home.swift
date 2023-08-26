//
//  Home.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 25/08/2023.
//

import SwiftUI

struct Home: View {
    @ObservedObject
    var router = Router<Path>(root: .MainScreen)
    var body: some View {
        RouterView(router: router)  { path, val in
            switch path {
            case .MainScreen: MainAppView()
            case.EnergyScreen: EnergyScreen()
            case.FlightScreen: FlightScreen()
            case.chartScreen: ChatScreen(list: val as! [DataModel])
            case .HistoryScreen: HistoryScreen(list: val as! [DataModel])
                

                
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
          .environmentObject(Router<Path>(root: .MainScreen))
        
    }
}




