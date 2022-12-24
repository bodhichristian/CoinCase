//
//  SearchBarView.swift
//  CoinCase
//
//  Created by christian on 11/30/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty
                    ? .theme.secondaryText
                    : .theme.accent
                )
            
            TextField("Search by name or symbol", text: $searchText)
                .keyboardType(.alphabet)
                .disableAutocorrection(true)
                .foregroundColor(.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.theme.accent)
                        .opacity(
                            searchText.isEmpty
                            ? 0.0
                            : 1.0
                        )
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,
                    alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: .theme.accent.opacity(0.15),
                    radius: 10
                )
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
