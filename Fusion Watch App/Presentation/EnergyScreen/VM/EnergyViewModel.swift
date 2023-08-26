//
//  EnergyViewModel.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 25/08/2023.
//

import Foundation

class EnergyViewModel : ObservableObject {
    @Service private var repository : HttpRepository
    @Service  private var supaBaseRepo: SupaBaseRepository
    @Published var data: ResultState<DataModel, String> = .idle
    @Published var carbonVal : Double = 0.0
    @Published var hasError : Bool = false
    
    
    
    init() {
        self.getEnergy()
    }
  
    
    func calEnergy(value: Int, state: String) {
        self.data = .loading
    let req = EnergyReq(type: "electricity", electricityUnit: "kwh", electricityValue: value, country: "us", state: state)
        if((value == .zero) || (state.isEmpty)){
            return
        } else{
            repository.createEnergy(session: .customSession, body: req) { result in
                switch result {
                case .success(let res):
                    self.data = .success(DataModel(carbonKg: res.datum?.attributes?.carbon_kg ?? 0.0, createdAt: res.datum?.attributes?.estimated_at ?? "", name: "Energy"))
                case .failure(let err):
                    print("printed \(err.localizedDescription)")
                    self.hasError = true
                    self.data = .failure(err.errorDescription ?? "")
            
                }
            }
        }

    }
    
    
    func getEnergy(){
        self.data = .loading
        Task{
            do {
                let result = try  await supaBaseRepo.getRequest(table: "Carbon")
                let res = result?.filter{$0.name == "Energy"}.last
                self.data = .success(res ?? DataModel(carbonKg: 0.0, createdAt: "", name: ""))
                hasError = false
            }
            catch{
                self.data = .idle
                hasError = true
                self.data = .failure(error.localizedDescription)
            }
        }
     
    }
    
    
    
    private func roundedValue() -> Decimal {
        return Decimal(ceil(carbonVal))
    }
}



