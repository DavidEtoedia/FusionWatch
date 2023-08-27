//
//  HistoryScreen.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 24/08/2023.
//

import SwiftUI

struct HistoryScreen: View {
    // MARK: Navigation path
    @EnvironmentObject var router: Router<Path>
    @EnvironmentObject private var supaBaseVm: SupbaseViewModel
    //MARK: Navigation Path
    @State private var isSelected: Bool = false
    @State private var showAlert: Bool = false
    @State private var isloading: Bool = false
    @State private var selectedid: String = ""
    let list : [DataModel]
    var body: some View {
        VStack {
            HStack(alignment:.center) {
                Text("History")
                    .font(.custom(Font.climateCrisis, size: 15))
                    .foregroundColor(.white)
                Spacer()
                
                Text("View chart")
                    .font(.system(size:13))
                    .foregroundColor(.blue)
                    .onTapGesture {
                        router.push(.chartScreen, value: list)
                    }
                
            }
            
            if(supaBaseVm.result.isLoading && supaBaseVm.delete.isLoading){
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1)
                    .padding(.vertical, 10)
            }
            else{
                ScrollView(showsIndicators: false) {
                    ForEach(supaBaseVm.result.value ?? [], id: \.id) { value in
                        
                        CarbonHistory(value: value) {
                            
                            Rectangle()
                                .frame(width: 25, height: 35)
                                .foregroundColor(.gray.opacity(0.2))
                                .overlay {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                }
                                .onTapGesture {
                                    showAlert = true
                                    selectedid = value.id.description
                                }
                            
                        }
                        
                    }
                    
                }
                .alert("Loading", isPresented: $supaBaseVm.isLoading) {
                    
                }
                
                
            }
            
        }
        .alert("Delete Alert", isPresented: $showAlert, actions: {
            HStack {
                
                Button(role: .none, action: {
                    showAlert = false
                    isloading = true
                    supaBaseVm.delete(id: selectedid.lowercased())
                    
                }, label: {
                    Text("Delete")
                        .foregroundColor(.red)
                })
                Button("Cancel", role: .cancel){}
            }
        })
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.bottom)
        .background(.black)
    }
    
    

}

struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen( list: mockResponse)
            .environmentObject(SupbaseViewModel())
    }
}



struct CarbonHistory<Content: View>: View {
    var value: DataModel
    @ViewBuilder let content: () -> Content
    var body: some View {
        
        HStack {
            HStack {
                VStack(alignment:.leading) {
                    Text(value.name)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    Space(height: 10)
                    Text(value.createdAt.formattedDate)
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.4))
                }
                Spacer()
                HStack(alignment:.center, spacing: 2) {
                    Text(String(value.carbonKg.rounded(toDecimalPlaces: 1)))
                        .font(.custom(Font.climateCrisis, size: 10))
                        .foregroundColor(.white)
                    
                    Text("Kg")
                        .font(.custom(Font.climateCrisis, size: 10))
                        .foregroundColor(.white)
                }
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background{
                Rectangle()
                    .foregroundColor(.gray.opacity(0.15))
            }
            .padding(.vertical, 8)
            Spacer()
            content()
          
            
        }
    }
}




