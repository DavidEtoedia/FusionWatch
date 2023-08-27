//
//  SheetView.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 15/07/2023.
//

import SwiftUI

struct SheetView: View {
    @Binding var isSheetPresent: Bool
    @Binding var selectedState: StateModel?
     var state: [StateModel] = StateModel.allState
    @State private var searchText = ""
    var  filterState : [StateModel] {
        if(searchText.isEmpty){
            return state
        } else {
            return state.filter {$0.name.lowercased().contains(searchText.lowercased())}
        }
    }
    var body: some View {
        VStack {
            Space(height: 10)
            SearchBar(searchText: $searchText)
            Space(height: 20)
            ScrollView {
                ForEach(filterState, id: \.name) { value in
                   
                    Text(value.name)
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
                            selectedState = value
                        }
                      
                }
                .frame(maxWidth: .infinity)
            
            }
      
       
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.black)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(isSheetPresent: .constant(false), selectedState: .constant(StateModel()))
    }
}


struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Find", text: $searchText)
                .padding(.leading, 10)
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .opacity(searchText.isEmpty ? 0 : 1)
            }
            .padding(.trailing, 10)
        }
        .frame(height: 10)
        .padding(.vertical, 8)
        .background(Color(.white))
        .cornerRadius(5)
    }
}
