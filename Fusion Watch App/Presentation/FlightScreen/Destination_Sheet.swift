//
//  SheetView.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 15/07/2023.
//

import SwiftUI

struct DestinationSheet: View {
    @Binding var isSheetPresent: Bool
    @Binding var selectedCode: IATAModel

     var iata: [IATAModel] = IATAModel.allCode
    @State private var searchText = ""
    var  filterState : [IATAModel] {
        if(searchText.isEmpty){
            return iata
        } else {
            return iata.filter {$0.name.lowercased().contains(searchText.lowercased())}
        }
    }
    var body: some View {
        VStack {
         
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.gray.opacity(0.3))
                .overlay {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                       
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onTapGesture {
                    isSheetPresent = false
                }
     
            Space(height: 20)
            SearchBar(searchText: $searchText)
            Space(height: 20)
            ScrollView {
                ForEach(filterState, id: \.code) { value in
                   
                    Text(value.name)
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            Rectangle()
                            .foregroundColor(.gray.opacity(0.12)))
                        .padding(.vertical, 1)
                        .onTapGesture {
                            isSheetPresent = false
                            selectedCode = value
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

struct DestinationSheet_Previews: PreviewProvider {
    static var previews: some View {
        DestinationSheet(isSheetPresent: .constant(false), selectedCode: .constant(IATAModel()))
    }
}


