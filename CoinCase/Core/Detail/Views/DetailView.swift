//
//  DetailView.swift
//  CoinCase
//
//  Created by christian on 12/4/22.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    @State private var showingFullDescription = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())

    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
          
                VStack(spacing: 20) {
                    
                    overviewTitle
                    Divider()
                    
                    descriptionSection
                    
                    overviewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                    
                    linksSection
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: CoinModel.example)
        }
    }
}

extension DetailView {
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(.theme.secondaryText)
            
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = viewModel.coinDescription, !coinDescription.isEmpty {
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(coinDescription)
                        .lineLimit(showingFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                    Button {
                        showingFullDescription.toggle()

                    } label: {
                        Text(showingFullDescription ? "Less" : "Read more...")
                            .font(.subheadline)
                            .tint(.blue)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var linksSection: some View {
        HStack {
            Image(systemName: "arrow.up.right.square.fill")
                .foregroundColor(.blue)
            if let websiteString = viewModel.websiteURL,
               let url = URL(string: websiteString) {
                Link("\(viewModel.coin.name) wesbite", destination: url)
            }
            
            Spacer()
            
            Image(systemName: "arrow.up.right.square.fill")
                .foregroundColor(.blue)
            if let redditString = viewModel.redditURL,
               let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .padding(.vertical, 5)
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.subheadline)
        
    }
    
    private var overviewGrid: some View {
                LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.overviewStats) { stat in
                    StatView(stat: stat)
                }
            })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.additionalStats) { stat in
                    StatView(stat: stat)
                }
            })
    }
}
