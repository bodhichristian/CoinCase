//
//  CoinRowHelpers.swift
//  CoinCase
//
//  Created by christian on 11/28/22.
//

import SwiftUI

//Leftmost column in CoinRowView
struct CoinColumn: View {
    let coin: CoinModel
    
    var body: some View {
        Text("\(coin.rank)")
            .font(.caption)
            .foregroundColor(.theme.secondaryText)
            .frame(minWidth: 30)
        CoinImageView(coin: coin)
            .frame(width: 30, height: 30)
        Text(coin.symbol.uppercased())
            .font(.headline)
            .padding(.leading, 6)
            .foregroundColor(.theme.accent)
    }
}

//Middle column in CoinRowView
struct HoldingsColumn: View {
    let coin: CoinModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .fontWeight(.medium)
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
    }
}

//Rightmost column in CoinRowView
struct PriceColumn: View {
    let coin: CoinModel
    
    var body: some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Text(coin.priceChangePercentage24H?.asPercentSring() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0
                    ? .theme.green
                    : .theme.red
                )
        }
        //frame used rather than GeometryReader since app only supports portrait orientation
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinRowHelpers_PreviewProvider: PreviewProvider {
    static var previews: some View{
        HStack(spacing: 0) {
            CoinColumn(coin: CoinModel.example)
            Spacer()
            HoldingsColumn(coin: CoinModel.example)
            PriceColumn(coin: CoinModel.example)
        }
        }
    }

