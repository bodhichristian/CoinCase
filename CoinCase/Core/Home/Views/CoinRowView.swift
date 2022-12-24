//
//  CoinRowView.swift
//  CoinCase
//
//  Created by christian on 11/28/22.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showingHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            CoinColumn(coin: coin)
            
            Spacer()
            
            if showingHoldingsColumn {
                HoldingsColumn(coin: coin)
            }
            
            PriceColumn(coin: coin)
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: CoinModel.example, showingHoldingsColumn: true)
    }
}


