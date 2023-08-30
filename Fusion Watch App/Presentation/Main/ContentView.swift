//
//  ContentView.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 23/08/2023.
//

import SwiftUI


struct Space: View {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var body: some View {
        Spacer()
            .frame(width: width, height: height)
    }
}

struct MainAppView: View {
    @EnvironmentObject var router: Router<Path>
    @EnvironmentObject private var supabaseVM: SupbaseViewModel
    
    // MARK: Navigation path

    // States
    private let outerDialSize: CGFloat = 200
    private let innerDialSize: CGFloat = 172
    private let setpointSize: CGFloat = 15
    private let ringSize: CGFloat = 220
    private let minTemperature: CGFloat = 4
    private let maxTemperature: CGFloat = 30
    @State private var currentTemperature: CGFloat = 0
    @State private var degrees: CGFloat = 36
    @State private var showStatus = false
    @State private var units : [String] = ["Kg", "mt", "lb"]
    @State private var selectedUnit = "Kg"
    //Circle Timer
    @State private var borderanim1: CGFloat = 0.0
    let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
  
    @State private var borderanim2: CGFloat = 0.0
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    //Gradient
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.orange, Color.pink]),
        center: .center,
        startAngle: .degrees(180),
        endAngle: .degrees(0))

    var degree: CGFloat = 0
    var ringValue: CGFloat {
        currentTemperature / 50
    }
    
    
    
    var body: some View {
        ScrollView{
            
            HStack{
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 10, height: 10)
                Text("Hi David,")
                    .font(.system(size:10))
                    .foregroundColor(.white)
                    .padding(.leading, 6)
                 Spacer()
                
            
            }
            .frame(maxWidth: .infinity, alignment:  .leading)
            Space(height: 20)
            ZStack(alignment:.center) {
                ZStack{
                    Circle()
                        .stroke(Color.gray, lineWidth: 10).opacity(0.3)
                        .frame(width: 120, height: 120, alignment: .center)
                    
                    
                    
                    Circle()
                        .trim( from: 0, to:
                               self.borderanim1
                        )
                        .stroke(gradient, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 120, height: 120, alignment: .center)
                        .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                        .rotationEffect(.degrees(180))
                    
                        .onReceive(timer1) { _ in
//                                withAnimation {
//                                    guard self.borderanim1 < 0.65 else { return }
//                                    self.borderanim1 += 0.65
//
//                                }
                        }
                    
                    
                }
                
              
                VStack(spacing:0) {
                    Space(height: 10)
                    Text(String( carbonFt(value: selectedUnit)))
                        .font(.custom(Font.climateCrisis, size: 20))
                    .foregroundColor(.white)
              
                        Text("CO2e/\(selectedUnit)")
                            .font(.system(size:10))
                        .foregroundColor(.white)
                     Space(height: 10)
                    
                    Text("Total emission")
                        .font(.system(size:9))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .frame(width: 100, height: 100)
            .padding(.horizontal)
            .padding(.bottom, 30)

            Text("View History")
                .font(.system(size:12))
                .foregroundColor(.blue)
                .onTapGesture {
                    router.push(.HistoryScreen, value: supabaseVM.result.value ?? [])
                }

            Space(height: 20)
          // MARK: Containers -------------->
            
            CarbonCard(name: "Energy", value:String(  supabaseVM.energy?.carbonKg.rounded(toDecimalPlaces: 1) ?? 0.0), image: "light", isLoading: supabaseVM.result.isLoading)
                .onTapGesture {
                    router.push(.EnergyScreen, value: nil)
                }
            
            CarbonCard(name: "Flights", value:String(  supabaseVM.flight?.carbonKg.rounded(toDecimalPlaces: 1) ?? 0.0), image: "plane", isLoading: supabaseVM.result.isLoading)
                .onTapGesture {
                    router.push(.FlightScreen)
                }
            
            CarbonCard(name: "logistics", value:String(  supabaseVM.logistics?.carbonKg.rounded(toDecimalPlaces: 1) ?? 0.0), image: "ship", isLoading: supabaseVM.result.isLoading)
                .onTapGesture {
                    router.push(.LogisticsScreen, value: nil)
                }
                
        }
        .padding(.horizontal, 10)
        .background(.black)
        .edgesIgnoringSafeArea(.bottom)
        .alert("Error", isPresented: $supabaseVM.hasError, actions: {
            Button("Ok", role: .cancel, action: {})
        }, message: {
            Text("An Error occured")
        })
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                   borderanim1 = (supabaseVM.carbonFTP) / 100
                }
            }
       
        }
        
       
    }
    
    
    
    
    
    
    
    
    
    
    
    @ViewBuilder
    func CarbonCard(name: String, value: String, image: String, isLoading: Bool)-> some View {
        
        Rectangle()
            .cornerRadius(5)
            .frame(height: 30)
            .foregroundColor(Color.gray.opacity(0.2))
            .overlay {
                HStack {
                    Label {
                        Text(name)
                            .font(.system(size:10))
                            .foregroundColor(.white)
                    } icon: {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .padding(5)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                    }
                   Spacer()
                   
                        if(isLoading){
                            ProgressView()
                                .tint(.white)
                                .scaleEffect(0.4)

                        }else{

                            Text(value)
                                .font(.custom(Font.climateCrisis, size: 10))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.1), radius: 20)

                            Text("Kg")
                                .font(.custom(Font.climateCrisis, size: 10))
                                .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.1), radius: 20)
                        }


                
                }
                .frame(maxWidth: .infinity, alignment:  .trailing)
                .padding(.leading, 10)
                .padding(.trailing, 15)
            }
    }
    
    
    
    
    func carbonFt(value: String) -> Double {
        switch value {
        case "kg":
            return  supabaseVM.carbonFTP.rounded(toDecimalPlaces: 1)
        case "mt":
          let result =  supabaseVM.carbonFTP.rounded(toDecimalPlaces: 1) / 1000
            return  result.rounded(toDecimalPlaces: 1)
        case "lb":
           let result =  supabaseVM.carbonFTP.rounded(toDecimalPlaces: 1) * 2.20462
            
            return result.rounded(toDecimalPlaces: 1)
        default:
            return  supabaseVM.carbonFTP.rounded(toDecimalPlaces: 1)
        }
        
    }
    
    
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
            .environmentObject(SupbaseViewModel())
            .environmentObject(Router(root: Path.MainScreen))
        
    }
}
