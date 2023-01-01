//
//  HomeView.swift
//  CoinCase
//
//  Created by christian on 11/28/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showingPortfolio = false // animate right
    @State private var editingPortfolio = false // new sheet
    @State private var showingInfo = false // new sheet
    
    var body: some View {
        ZStack {
            //background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $editingPortfolio) {
                    EditPortfolioView()
                }
            //content layer
            VStack {
                homeHeader
                HomeStatView(showingPortfolio: $showingPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles
                
                if !showingPortfolio {
                    allCoinsView
                        .transition(.move(edge: .leading))
                } else {
                    portfolioCoinsView
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showingInfo, content: {
                InfoView()
            })
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        
        HStack {
            CircleButtonView(iconName: showingPortfolio ? "plus" :  "info")
            //disables animation on the transaction between states directly
            //replaces .animation(nil)
                .transaction { transaction in
                    transaction.animation = nil
                }
                .onTapGesture {
                    if showingPortfolio {
                        editingPortfolio.toggle()
                    } else {
                        showingInfo.toggle()
                    }
                }
            Spacer()
            Text(showingPortfolio ? "Portolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showingPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showingPortfolio.toggle()
                    }
                }
                .padding(.horizontal)
        }
    }
}

extension HomeView {
    private var allCoinsView: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                NavigationLink(
                    destination: DetailView(coin: coin),
                    label: {
                        CoinRowView(coin: coin, showingHoldingsColumn: false)
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    })
                
            }
        }
        .refreshable {
            viewModel.reloadData()
            
        }
        .listStyle(.plain)
        .transition(.move(edge: .leading))
        
    }
    
    private var portfolioCoinsView: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                NavigationLink(
                    destination: DetailView(coin: coin),
                    label: {
                        CoinRowView(coin: coin, showingHoldingsColumn: true)
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    })
            }
        }
        .listStyle(.plain)
        //.transition(.move(edge: .leading))
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity( (viewModel.sortOption == .rankAscending || viewModel.sortOption == .rankDescending)
                              ? 1.0
                              : 0.0
                    )
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rankAscending
                                          ? 0
                                          : 180)
                    )
            }
            .onTapGesture {
                withAnimation {
                    viewModel.sortOption = viewModel.sortOption == .rankAscending ? .rankDescending : .rankAscending
                }
            }
            
            Spacer()
            if showingPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity( (viewModel.sortOption == .holdingsAscending || viewModel.sortOption == .holdingsDescending)
                                  ? 1.0
                                  : 0.0
                        )
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdingsAscending
                                              ? 0
                                              : 180)
                        )
                }
                .onTapGesture {
                    withAnimation {
                        viewModel.sortOption = viewModel.sortOption == .holdingsAscending ? .holdingsDescending : .holdingsAscending
                    }
                }
            }
            HStack {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity( (viewModel.sortOption == .priceAscending || viewModel.sortOption == .priceDescending)
                              ? 1.0
                              : 0.0
                    )
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .priceAscending
                                          ? 0
                                          : 180)
                    )
            }
            .onTapGesture {
                withAnimation {
                    viewModel.sortOption = viewModel.sortOption == .priceAscending ? .priceDescending : .priceAscending
                }
            }
            
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(HomeViewModel())
        .preferredColorScheme(.dark)
    }
}
