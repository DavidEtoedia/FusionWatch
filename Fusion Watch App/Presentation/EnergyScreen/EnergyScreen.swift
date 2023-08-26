//
//  energy_screen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 18/06/2023.
//

import SwiftUI

struct EnergyScreen: View {
    @EnvironmentObject private var energyVm: EnergyViewModel
    @Environment(\.presentationMode) var dismiss

    @State  private var inputValue: Int = 0
    @State private var currentTemperature: CGFloat = 50
    @State private var degrees: CGFloat = 36
    @State private var showStatus = false
    @State private var isSheetPresented = false
    
    // State
    var state: [StateModel] = StateModel.allState
    @State private var selectedState = StateModel()
    @State private var selectedValue : StateModel?
    @State var alphaCode: String = "AL"

    var ringValue: CGFloat = 1
    var body: some View {
        VStack(alignment: .leading) {
            BackButton()
                .padding(.horizontal, 20)
            
            Space(height: 10)
            ScrollView {
                Descriptions(title: "Calculate Electricity Consumption")
              
                Space(height: 5)
                
                CircleView(
                    carbonValue: String(
                        energyVm.data.value?.carbonKg.rounded(toDecimalPlaces: 1) ?? Double(0.0)
                    ), isLoading: energyVm.data.isLoading)
             
                
                VStack(alignment:.center){
                    HStack {
                        TextField("Enter value", value: $inputValue, formatter: NumberFormatter())
                            .textContentType(.telephoneNumber)
                            .padding(.trailing,5)
                            .frame(width: 70)
                            .accessibilityIdentifier("Enter Kwh")

                        Text("kwh")
                            .font(.system(size: 15))
                            .foregroundColor(.gray.opacity(0.8))
                          
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    Space(height: 20)
            
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width:100, height: 25)
                        .cornerRadius(5)
                        .overlay {
                            HStack  {
                                if(selectedValue?.name == nil){
                                    Text("Select")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black.opacity(0.5))
                                } else{
                                    Text(selectedValue!.name)
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
                            SheetView(isSheetPresent: $isSheetPresented, selectedState: $selectedValue)
                        }
                       
                }
                
               Spacer()
                    .frame(height: 20)
                AppButton(isLoading: energyVm.data.isLoading)
                    .onTapGesture {
                        if((inputValue == .zero) || (selectedValue == nil) ){
                            return
                        }
                        else{
                            
                            energyVm.calEnergy(value: inputValue, state: selectedValue?.abbreviation.lowercased() ?? "AL")
                            // closeKeyboard()
                        }
                    }
                    .accessibilityIdentifier("calculate")

            }
            .padding(.horizontal, 30)
            .onTapGesture {
               // KeyboardHelper.closeKeyboard()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
            .alert("Info", isPresented:  $energyVm.hasError, actions: {
                HStack {
                    Button("Cancel", role: .cancel, action: {})
                    
                }
            }, message: {
                Text(energyVm.data.error ?? "")
            })
            
            Spacer()
        
        }
        .background(.black)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
    }
}

struct EnergyScreen_Previews: PreviewProvider {
    static var previews: some View {
//
        let _ = ServiceContainer.register(type: HttpRepository.self, HttpRepositoryImp())
        EnergyScreen()
            .environmentObject(EnergyViewModel())
    }
}


