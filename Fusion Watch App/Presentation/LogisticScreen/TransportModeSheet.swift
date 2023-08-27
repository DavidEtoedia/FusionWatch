//
//  TransportModeSheet.swift
//  Fusion Watch App
//
//  Created by Inyene Etoedia on 26/08/2023.
//

import SwiftUI

struct TransportModeSheet: View {
    @Binding var isSheetPresent: Bool
    @Binding var selectedMethod: String
    @State private var searchText = ""
     var methods: [String] = ["truck", "ship", "train", "plane"]
    var body: some View {
        VStack {

            Space(height: 20)
            ScrollView {
                ForEach(methods, id: \.self) { value in
                   
                    Text(value)
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            Rectangle()
                            .foregroundColor(.gray.opacity(0.12)))
                        .padding(.vertical, 1)
                        .onTapGesture {
                            isSheetPresent = false
                            selectedMethod = value
                        }
                      
                }
                .frame(maxWidth: .infinity)
            
            }
       
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.black)
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct TransportModeSheet_Previews: PreviewProvider {
    static var previews: some View {
        TransportModeSheet(isSheetPresent: .constant(true), selectedMethod: .constant("truck"))
    }
}
