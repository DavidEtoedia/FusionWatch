//
//  FlightScreen.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 25/08/2023.
//

import SwiftUI

struct FlightScreen: View {
    @EnvironmentObject private var flightVm: FlightViewModel
    @State private var showStatus = false
    @State  private var passenger: Int = 0
    @State private var isDestinationSheet = false
    @State private var isDepartureSheet = false
    @State private var selectedDeparture = IATAModel()
    @State private var selectedDestination = IATAModel()
    @State private var listState : [LegReq] = []

    // PICKer
    @State  private var initial: String = "Select"
    @FocusState private var isTextFieldFocused: Bool
    var ringValue: CGFloat = 1
    var body: some View {

        VStack(alignment: .leading) {
            BackButton()
                .padding(.horizontal, 50)
                    Space(height: 10)
            ScrollView {
                Descriptions(title: "Calculate flights")
                                
                CircleView(
                    carbonValue: String(
                        flightVm.data.value?.carbonKg.rounded(toDecimalPlaces: 1) ?? Double(0.0)
                    ), isLoading: flightVm.data.isLoading)
                
                VStack {
                    Text("Enter passengers")
                        .font(.system(size: 13))
                        .foregroundColor(.gray.opacity(0.8))
                    
                    TextField("passengers", value: $passenger,
                              formatter: NumberFormatter())
                    .font(.system(size: 14))
                    .textContentType(.telephoneNumber)
                    .focused($isTextFieldFocused)
                    .frame(width: 120)
                    .accessibilityIdentifier("Enter passenger")
                    
                    
                    Space(height: 20)
                    VStack(spacing: 10) {
                        VStack(alignment:.leading){
                            Text("Departure airport")
                                .font(.system(size: 13))
                                .foregroundColor(.gray.opacity(0.8))
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width:130, height: 33)
                                .cornerRadius(5)
                                .overlay {
                                    HStack  {
                                        if(selectedDeparture.name.isEmpty){
                                            Text(initial)
                                                .font(.system(size: 14))
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .foregroundColor(.black.opacity(0.4))
                                        } else {
                                            Text(selectedDeparture.name)
                                                .font(.system(size: 14))
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .foregroundColor(.black)
                                        }
                                        
                                        
                                        Spacer()
                                        Image(systemName:"chevron.down")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10)
                                            .frame(width: 10)
                                            .foregroundColor(Color.blue)
                                        
                                    }
                                    .padding([.leading, .trailing], 10)
                                    
                                }
                                .onTapGesture {
                                    isDepartureSheet = true
                                }
                                .sheet(isPresented: $isDepartureSheet) {
                                    DepartureSheet(isSheetPresent: $isDepartureSheet, selectedCode: $selectedDeparture)
                                }
                                .accessibilityIdentifier("Departure")
                            
                            
                        }
                        
                        
                        VStack(alignment:.leading){
                            Text("Destination airport")
                                .font(.system(size: 13))
                                .foregroundColor(.gray.opacity(0.8))
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width:130, height: 33)
                                .cornerRadius(5)
                                .overlay {
                                    HStack  {
                                        if(selectedDestination.name.isEmpty){
                                            Text(initial)
                                                .font(.system(size: 14))
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .foregroundColor(.black.opacity(0.4))
                                        } else {
                                            Text(selectedDestination.name)
                                                .font(.system(size: 14))
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .foregroundColor(.black)
                                        }
                                        
                                        Spacer()
                                        Image(systemName:"chevron.down")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10)
                                            .frame(width: 10)
                                            .foregroundColor(Color.blue)
                                        
                                    }
                                    .padding([.leading, .trailing], 10)
                                    
                                }
                                .onTapGesture {
                                    isDestinationSheet = true
                                }
                                .sheet(isPresented: $isDestinationSheet) {
                                    DestinationSheet(isSheetPresent: $isDestinationSheet, selectedCode: $selectedDestination)
                                }
                                .accessibilityIdentifier("Destination")
                        }
                        
                    }
                  
                    Spacer()
                        .frame(height: 20)
                    AppButton(isLoading: flightVm.data.isLoading)
                        .onTapGesture {
                            
                            let val = LegReq(departureAirport: selectedDeparture.code, destinationAirport: selectedDestination.code)
                            
                            listState.append(val)
                            
                            flightVm.createFlight(passengers: passenger, legs: listState)
                        }
                        .accessibilityIdentifier("calculate")
                    
                    
                }
                .padding(.horizontal, 55)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            
            .frame(maxWidth: .infinity)
            .alert("Info", isPresented:  $flightVm.hasError, actions: {
                HStack {
                    Button("Cancel", role: .cancel, action: {})
                    
                }
            }, message: {
                Text(flightVm.data.error ?? "")
            })
                        
        }
        .background(.black)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)

        
    }
}

struct FlightScreen_Previews: PreviewProvider {
    static var previews: some View {
        FlightScreen()
            .environmentObject(FlightViewModel())
    }
}

