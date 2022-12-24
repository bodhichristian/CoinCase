//
//  HomeViewModel.swift
//  CoinCase
//
//  Created by christian on 11/28/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatModel] = [
        StatModel(title: "Title", value: "Value", percentageChange: 1),
        StatModel(title: "Title", value: "Value"),
        StatModel(title: "Title", value: "Value"),
        StatModel(title: "Title", value: "Value", percentageChange: -7)
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdingsAscending
    
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rankAscending, rankDescending, holdingsAscending, holdingsDescending, priceAscending, priceDescending
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        //updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.4), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        //updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
                    .sink { [weak self] (returnedStats) in
                        self?.statistics = returnedStats
                    }
                    .store(in: &cancellables)
                
                
            
    }
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        coinDataService.getCoins()
        marketDataService.getData()
    }
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
        
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    //using inout before the coins parameter allows us to perform the function in place
    //using .sort() rather than .sorted() sorts array in place
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rankAscending, .holdingsAscending:
            
            coins.sort(by: { $0.rank < $1.rank } )
        case .rankDescending, .holdingsDescending:
            coins.sort(by: { $0.rank > $1.rank } )
        case .priceAscending:
            coins.sort(by: { $0.currentPrice < $1.currentPrice } )
        case .priceDescending:
            coins.sort(by: { $0.currentPrice > $1.currentPrice } )
            
            }
        
        }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        //will only sort by holdingsAscending or holdingsDescended if needed
        switch sortOption {
        case .holdingsAscending:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsDescending:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue })

        default:
            return coins
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatModel] {
        var stats: [StatModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let portfolioValue =
        portfolioCoins
            .map( {$0.currentHoldingsValue })
        //combines items in array down to one object (starting point, combination method)
            .reduce(0, +)
        
        let previousPortfolioValue =
        portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousPortfolioValue) / previousPortfolioValue) //* 100
        
        
        
        let marketCap = StatModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatModel(title: "24H Volume", value: data.volume)
        let btcDominance = StatModel(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = StatModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}


