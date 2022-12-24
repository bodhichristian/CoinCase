//
//  MarketDataModel.swift
//  CoinCase
//
//  Created by christian on 11/30/22.
//

import Foundation
//JSON data:
/*
 
 URL: https://api.coingecko.com/api/v3/global

 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 13149,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 610,
     "total_market_cap": {
       "btc": 52678447.121781096,
       "eth": 698957155.2160416,
       "ltc": 11482089864.637428,
       "bch": 7972489774.945112,
       "bnb": 2988260064.3020687,
       "eos": 949136269222.5863,
       "xrp": 2225664767725.766,
       "xlm": 10003413237649.088,
       "link": 120403738010.67169,
       "dot": 165476673260.47205,
       "yfi": 134150617.85311306,
       "usd": 883393673816.932,
       "aed": 3244704963929.6016,
       "ars": 147755100792109.53,
       "aud": 1316924419604.6372,
       "bdt": 89775708958124.48,
       "bhd": 333012029825.0961,
       "bmd": 883393673816.932,
       "brl": 4649035887196.382,
       "cad": 1197342951554.737,
       "chf": 839285827683.2566,
       "clp": 786485387799218.1,
       "cny": 6265469631546.586,
       "czk": 20838290332662.344,
       "dkk": 6366859373671.596,
       "eur": 855965183638.5918,
       "gbp": 740059516665.4434,
       "hkd": 6895581088175.115,
       "huf": 350554132777306.06,
       "idr": 13875781722264998,
       "ils": 3047708174668.422,
       "inr": 71937805167811.98,
       "jpy": 123041500221825.69,
       "krw": 1164756904337833.8,
       "kwd": 271917406737.59033,
       "lkr": 325453907015133,
       "mmk": 1854593695590833.8,
       "mxn": 17135480377726.793,
       "myr": 3955660192617.47,
       "ngn": 392126506558079.9,
       "nok": 8783533828716.052,
       "nzd": 1416617162482.2244,
       "php": 49954591580805.28,
       "pkr": 197880182934993.16,
       "pln": 4001444719944.0537,
       "rub": 54008486916738.71,
       "sar": 3320804028566.8887,
       "sek": 9382571029474.379,
       "sgd": 1209189260720.6216,
       "thb": 31210298495952.312,
       "try": 16458419197515.9,
       "twd": 27304109232462.24,
       "uah": 32609375877040.902,
       "vef": 88454208559.28984,
       "vnd": 21863993426969140,
       "zar": 15008203040043.736,
       "xdr": 671971949256.001,
       "xag": 40853503344.768585,
       "xau": 504108599.9636339,
       "bits": 52678447121781.09,
       "sats": 5267844712178110
     },
     "total_volume": {
       "btc": 3220772.126548675,
       "eth": 42734397.95913764,
       "ltc": 702017561.4717498,
       "bch": 487439821.20385176,
       "bnb": 182702893.64705256,
       "eos": 58030405359.92829,
       "xrp": 136077645386.18408,
       "xlm": 611610939321.8363,
       "link": 7361511671.3776245,
       "dot": 10117281088.397257,
       "yfi": 8201999.002395442,
       "usd": 54010888263.685936,
       "aed": 198381992592.51907,
       "ars": 9033780154651.727,
       "aud": 80517055744.41956,
       "bdt": 5488907073988.502,
       "bhd": 20360430537.873486,
       "bmd": 54010888263.685936,
       "brl": 284243101665.30084,
       "cad": 73205817843.7176,
       "chf": 51314124612.68034,
       "clp": 48085893821159.805,
       "cny": 383072225010.1922,
       "czk": 1274057766228.5952,
       "dkk": 389271216688.8814,
       "eur": 52333904193.986855,
       "gbp": 45247405599.35007,
       "hkd": 421597381445.3566,
       "huf": 21432958664963.33,
       "idr": 848368420994442.6,
       "ils": 186337564509.71686,
       "inr": 4398293617007.142,
       "jpy": 7522785047308.926,
       "krw": 71213499574578.55,
       "kwd": 16625091516.445198,
       "lkr": 19898325206273.92,
       "mmk": 113390276426012.77,
       "mxn": 1047667131265.6229,
       "myr": 241849955467.1336,
       "ngn": 23974702965019.15,
       "nok": 537027237396.0884,
       "nzd": 86612292506.75298,
       "php": 3054234985033.493,
       "pkr": 12098438971065.672,
       "pln": 244649231784.0639,
       "rub": 3302091059297.3354,
       "sar": 203034706551.1061,
       "sek": 573652506825.6881,
       "sgd": 73930103855.3336,
       "thb": 1908204682356.0305,
       "try": 1006271458151.9076,
       "twd": 1669379390642.5498,
       "uah": 1993744588676.3079,
       "vef": 5408110241.842899,
       "vnd": 1336769484526231.2,
       "zar": 917604915520.9343,
       "xdr": 41084516386.42633,
       "xag": 2497792399.6223693,
       "xau": 30821313.38767248,
       "bits": 3220772126548.675,
       "sats": 322077212654867.5
     },
     "market_cap_percentage": {
       "btc": 36.48717084534691,
       "eth": 17.255893537115455,
       "usdt": 7.396934166920503,
       "bnb": 5.472474804412688,
       "usdc": 4.903037774075631,
       "busd": 2.5066828714389517,
       "xrp": 2.2599426458040353,
       "doge": 1.5931899901858095,
       "ada": 1.2342020343241202,
       "matic": 0.8785404740492251
     },
     "market_cap_change_percentage_24h_usd": 1.7700829568106105,
     "updated_at": 1669829835
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentSring()
        }
        return ""
    }
}
