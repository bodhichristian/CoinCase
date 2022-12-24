//
//  StatView.swift
//  CoinCase
//
//  Created by christian on 11/30/22.
//

import SwiftUI

struct StatView: View {
    
    let stat: StatModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(.theme.accent)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                
                Text(stat.percentageChange?.asPercentSring() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? .theme.green : .theme.red)
        }
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatView(stat: StatModel.exampleStat1)
                .previewLayout(.sizeThatFits)
            StatView(stat: StatModel.exampleStat2)
                .previewLayout(.sizeThatFits)
            StatView(stat: StatModel.exampleStat3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
    }
        
    }
}
