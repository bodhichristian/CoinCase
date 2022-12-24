//
//  StatisticModel.swift
//  CoinCase
//
//  Created by christian on 11/30/22.
//

import Foundation

struct StatModel: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
    static let exampleStat1 = StatModel(title: "Market Cap", value: "12.58B", percentageChange: 25.34)
    static let exampleStat2 = StatModel(title: "Portfolio Value", value: "$50.5K", percentageChange: -4.76)
    static let exampleStat3 = StatModel(title: "Total Volume", value: "$1.23T")
}
