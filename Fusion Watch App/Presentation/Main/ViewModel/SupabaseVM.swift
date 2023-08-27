//
//  SupabaseVM.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import Foundation


class SupbaseViewModel: ObservableObject {
    @Service  private var supaBaseRepo: SupaBaseRepository
    @Published var dataValue: DataModel = DataModel(carbonKg: 0.0, createdAt: "", name: "Carbon")
    @Published var flight: DataModel?
    @Published var energy: DataModel?
    @Published var logistics: DataModel?
    @Published var result: ResultState<[DataModel], String> = .idle
    @Published var delete: ResultState<String?, String> = .idle
    @Published var hasError : Bool = false
    @Published var isLoading : Bool = false
    @Published var errorMsg : String = ""
    @Published var carbonFTP : Double = 0.0
    

    init() {
    //MARK: Get the response from supabase
        Task{
            await self.getTotal()
        }
//    //MARK: Listens to insert and delete event on the table
        getChannel()
    }
    
  
    @MainActor
    func getTotal()async {
        isLoading = true
        self.result = .loading
       
        do {
            let result = try  await supaBaseRepo.getRequest(table: "Carbon")
           
            let totalCarbonKg = result?.reduce(0) { $0 + $1.carbonKg }
            carbonFTP = totalCarbonKg ?? 0
          
            logistics = result?.filter{$0.name == "Logistics"}.first
            flight = result?.filter{$0.name == "Flight"}.first
            energy = result?.filter{$0.name == "Energy"}.first
           
            self.result = .success(result ?? [])
            hasError = false
            isLoading = false

            
        }
        catch{
            hasError = true
            isLoading = false
            self.result = .failure(error.localizedDescription)
        }
    }
    
    @MainActor
    func delete(id: String)  {
        isLoading = true
        self.delete = .loading
        Task {
            do{
              try await supaBaseRepo.delete(id: id)
                self.delete = .success("Success")
                isLoading = false
               
            }
            catch {
                hasError = true
                isLoading = false
                self.result = .failure(error.localizedDescription)
            }
        }
      
    }
    
    func getChannel(){
        let user =  supaBaseRepo.realTime()
        user.on(.insert) { message in
            print(message.payload)
            
    //MARK: Make a request to get the updated values on the Table
            Task{
                await self.getTotal()
            }
        }
        user.on(.delete) { message in
            print(message.payload)
            Task{
                await self.getTotal()
               
            }
        }
        user.subscribe()
        hasError = user.isErrored
    }
    
    func unsubscribe(){
        let user =  supaBaseRepo.realTime()
        user.unsubscribe()
    }
    

}

