//
//  Ship_screen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 27/07/2023.
//

import SwiftUI
import WatchKit

struct LogisticScreen: View {
    @EnvironmentObject private var shipVm: ShipViewModel
    @EnvironmentObject private var supaBase: SupbaseViewModel
    @State private var showStatus = false
    @State  private var distance: Int = 0
    @State  private var weight: Int = 0
    
    private var distanceUnit: [String] = ["km", "mi"]
    private var weightUnit: [String] = ["lb", "kg", "g", "mt"]
    @State private var selectedMethod  = "truck"
    @State private var selectedDistance  = "km"
    @State private var selectedWeight  = "kg"
    @State private var isSheetPresented = false

    
    @FocusState private var isDistance: Bool
    @FocusState private var isWeight: Bool
    
    var body: some View {
                VStack(alignment: .leading) {
                    ScrollView {
                    CircleView(
                        carbonValue: String(
                            shipVm.data.value?.carbonKg.rounded(toDecimalPlaces: 1) ?? Double(0.0)
                        ), isLoading: shipVm.data.isLoading)
                        
                        VStack(alignment: .center) {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Enter distance")
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray.opacity(0.8))
                                    
                                    HStack(spacing: 10) {
                                        TextField("distance", value: $distance, formatter: NumberFormatter())
                                            .font(.system(size: 14))
                                            .focused($isDistance)
                                            .frame(width: 50)
                                            .accessibilityIdentifier("distance")
                                          
                                        Text("km")
                                            .font(.system(size: 12))
                                    }
                                }
                                Spacer()
                                VStack(alignment: .leading){
                                    Text("Enter Weight")
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray.opacity(0.8))
                                    
                                    HStack(spacing: 10) {
                                        TextField("Weight", value: $weight, formatter: NumberFormatter())
                                            .font(.system(size: 14))
                                            .focused($isWeight)
                                            .frame(width: 50)
                                            .accessibilityIdentifier("weight")
                                        
                                        
                                        Text("kg")
                                            .font(.system(size: 12))
                                    }
                                }
                            
                            }
                            .padding(.horizontal, 10)
                            
                            Space(height: 20)
                            
                            Text("Transport mode")
                                .font(.system(size: 12))
                                .foregroundColor(.gray.opacity(0.8))
                            
                            Space(height: 10)
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width:100, height: 25)
                                .cornerRadius(5)
                                .overlay {
                                    HStack  {
                                        if(selectedMethod.isEmpty){
                                            Text("Select")
                                                .font(.system(size: 13))
                                                .foregroundColor(.black.opacity(0.5))
                                        } else{
                                            Text(selectedMethod)
                                                .font(.system(size: 14))
                                                .foregroundColor(.black)
                                        }
                                     
                                        Spacer()
                                        
                                        Image(systemName:"chevron.down")
                                            .foregroundColor(Color.blue)
                                            
                                        
                                    }
                                    .padding([.leading, .trailing], 5)
                                    
                                }
                                .onTapGesture {
                                    isSheetPresented = true
                                }
                                .sheet(isPresented: $isSheetPresented) {
                                    
                                    TransportModeSheet(isSheetPresent: $isSheetPresented, selectedMethod: $selectedMethod)
                                }
                               
                            Spacer()
                                .frame(height: 20)
                            AppButton(isLoading: shipVm.data.isLoading)
                                .onTapGesture {
                                    shipVm.createShip(weightValue: weight, weightUnit: selectedWeight, distanceValue: distance, distanceUnit: selectedDistance, transportMethod: selectedMethod)
                                }
                                .accessibilityIdentifier("calculate")
                         

                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .alert("Info", isPresented:  $shipVm.hasError, actions: {
                        HStack {
                            Button("Cancel", role: .cancel, action: {})
                            
                        }
                    }, message: {
                        Text(shipVm.data.error ?? "")
                    })
              
                    Spacer()

                }
                .edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden(false)
        
        }

}

struct LogisticScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogisticScreen()
            .environmentObject(ShipViewModel())
    }
}
