//
//  Descriptions.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 26/07/2023.
//

import SwiftUI

struct Descriptions: View {
    var title: String
    var body: some View {
    
            Text(title)
            .font(.system(size: 10))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Space(height: 20)
        
    }
}

struct Descriptions_Previews: PreviewProvider {
    static var previews: some View {
        Descriptions(title: "water ")
    }
}
