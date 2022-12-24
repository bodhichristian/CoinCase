//
//  CoinDataService.swift
//  CoinCase
//
//  Created by christian on 11/28/22.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        DispatchQueue.global().async {
            guard let url = URL(string:        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
            
            DispatchQueue.main.async {
                self.coinSubscription = NetworkingManager.download(url: url)
                    .decode(type: [CoinModel].self, decoder: JSONDecoder())
                    .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins)  in
                        self?.allCoins = returnedCoins
                        self?.coinSubscription?.cancel()
                    })
            }
            
        }
        
       
    }
}
