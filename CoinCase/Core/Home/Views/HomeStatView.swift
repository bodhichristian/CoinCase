//
//  HomeStatView.swift
//  CoinCase
//
//  Created by christian on 11/30/22.
//

import SwiftUI

struct HomeStatView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @Binding var showingPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(viewModel.statistics) { stat in
                StatView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showingPortfolio ? .trailing : .leading
        )
    }
}

struct HomeStatView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatView(showingPortfolio: .constant(false))
            .environmentObject(HomeViewModel())
    }
}
