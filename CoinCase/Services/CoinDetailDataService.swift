//
//  CoinDetailDataService.swift
//  CoinCase
//
//  Created by christian on 12/4/22.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        DispatchQueue.global().async {
            guard let url = URL(string:        "https://api.coingecko.com/api/v3/coins/\(self.coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
            else { return }
            
            DispatchQueue.main.async {
                self.coinDetailSubscription = NetworkingManager.download(url: url)
                    .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
                    .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails)  in
                        self?.coinDetails = returnedCoinDetails
                        self?.coinDetailSubscription?.cancel()
                    })
            }
            
        }
        
       
    }
}
