//
//  AppButton.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 26/07/2023.
//

import SwiftUI

struct AppButton: View {
    var isLoading : Bool = false
    var body: some View {
        Rectangle()
            .frame(width: 100, height: 30)
            .foregroundColor(.blue)
            .cornerRadius(5)
            .padding(.horizontal, 50)
            .overlay {
                if (isLoading){
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.vertical, 15)
                } else{
                    Text("Calculate")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                }
              
                   
            }
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton()
    }
}
