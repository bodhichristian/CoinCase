//
//  EditPortfolioView.swift
//  CoinCase
//
//  Created by christian on 12/1/22.
//

import SwiftUI

struct EditPortfolioView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        editPortfolioSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        XMarkButton()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        //save to portfolio model
                        save()
                        dismiss()
                        resetTextFields()
                    }
                    .disabled(quantityText == ""
                              //maybe this comes back to us later??
                              ///
                              ///CLEAN ME
                              ///
                              //&& selectedCoin?.currentHoldings != Double(quantityText)
                    )
                }
            })
            .onChange(of: viewModel.searchText, perform: { value in
                if value == "" {
                    resetTextFields()
                }
            })
        }
    }
}

struct EditPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortfolioView()
            .environmentObject(HomeViewModel())
    }
}


extension EditPortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.searchText.isEmpty
                        ? viewModel.portfolioCoins
                        : viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id
                                        ? Color.theme.green
                                        : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        })
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = viewModel.portfolioCoins.first(where: {$0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else { quantityText = ""
        }
        
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var editPortfolioSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                    .font(.headline)
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount in portfolio:")
                    .font(.headline)
                
                Spacer()
                TextField("Ex: 2.7", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                    .font(.headline)
                
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .padding()
    }
    
    private func save() {
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
        else { return }
        
        //save to portfolio
        viewModel.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func resetTextFields() {
        quantityText = ""
        viewModel.searchText = ""
        self.selectedCoin = nil
    }
}
