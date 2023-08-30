//
//  ChartScreen.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 25/08/2023.
//

import SwiftUI

import Charts

struct ChatScreen: View {
    
    let list : [DataModel]
    @State private var enteredText = ""
    @EnvironmentObject var router: Router<Path>

    
    var body: some View {
        VStack {
            Space(height: 40)
                HStack {
                    Image(systemName: "house.fill")
                        .resizable()
                    .frame(width: 11, height: 11)
                    .foregroundColor(.blue)
                    Text("Home")
                    .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment:.leading)
                .onTapGesture {
                    router.popToRoot()
                    
                }
        
            
            Space(height: 20)
 
            Chart {
                ForEach(list) { list in
                    BarMark(x: .value("Month", list.name), y: .value("values", list.carbonKg))
                }
            }
           // .chartYScale(domain: 0...1000)
            .chartXAxis {
                
                AxisMarks(values: .automatic) { value in
                AxisValueLabel() { // construct Text here
                  if let intValue = value.as(String.self) {
                    Text("\(intValue)")
                      .font(.system(size: 10)) // style it
                      .foregroundColor(.white)
                  }
                }
              }
            }
            
            .chartYAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine(centered: true, stroke: StrokeStyle(dash: [1, 2]))
                        .foregroundStyle(Color.cyan.opacity(0.3))
                      AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(Color.red)
                AxisValueLabel() { // construct Text here
                  if let intValue = value.as(Int.self) {
                    Text("\(intValue) kg")
                      .font(.system(size: 10)) // style it
                      .foregroundColor(.white)
                  }
                }
              }
            }
            .frame(height:150)
            
              Text(enteredText)
                .foregroundColor(.white)
            
        
        
        }
      
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(.black)
        
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(list: mockResponse)
    }
}





