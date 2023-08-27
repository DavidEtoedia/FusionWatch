//
//  LogisticsVM.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 26/08/2023.
//

import Foundation


class ShipViewModel: ObservableObject {
    @Service  private var supaBaseRepo: SupaBaseRepository
    @Published var data: ResultState<DataModel, String> = .idle
    @Service private var repository : HttpRepository
    @Published var hasError : Bool = false
    
    init(){
       getLogistics()
    }
    
    
    func createShip(weightValue:Int, weightUnit: String, distanceValue: Int, distanceUnit: String, transportMethod: String)
    {
        if( distanceValue == .zero || weightValue == .zero){
            return
        }
        self.data = .loading
        let ship = LogisticsReq(type: "shipping", weightValue: weightValue, weightUnit: weightUnit, distanceValue: distanceValue, distanceUnit: distanceUnit, transportMethod: transportMethod)
        
        repository.createShipping(session: .customSession ,body: ship) { result in
            switch result {
            case .success(let res):
                self.data = .success(DataModel(carbonKg: res.data?.attributes?.carbon_kg ?? 0.0, createdAt: res.data?.attributes?.estimated_at ?? "", name: "Logistics"))
                self.hasError = false
            case .failure(let err):
                self.hasError = true
                self.data = .failure(err.errorDescription ?? "")
            }
        }
    }
    
    func getLogistics(){
        self.data = .loading
        Task{
            
            do {
                let result = try  await supaBaseRepo.getRequest(table: "Carbon")
                let res = result?.filter{$0.name == "Logistics"}.last
                self.data = .success(res ?? DataModel(carbonKg: 0, createdAt: "", name: ""))
                hasError = false
            }
            catch{
                self.data = .idle
                hasError = true
                self.data = .failure(error.localizedDescription)
            }
        }
    }
    
}

