//
//  CoinModel.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 16.01.2024.
//

import Foundation


    
    // CoinGecko API Info
    /*
     
     URL:
     https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en
     
        {
           "market_cap":,
           "market_cap_rank":,
           "fully_diluted_valuation":,
           "total_volume":,
           "high_24h":,
           "low_24h":,
           "price_change_24h":,
           "price_change_percentage_24h":,
           "market_cap_change_24h":,
           "market_cap_change_percentage_24h":,
           "circulating_supply":,
           "total_supply":,
           "max_supply":,
           "ath":,
           "ath_change_percentage":,
           "ath_date":,
           "atl":,
           "atl_change_percentage":,
           "atl_date":"",
           "roi":null,
           "last_updated":,
           "sparkline_in_7d":{
              "price":[
                 
              ]
           },
           "price_change_percentage_24h_in_currency":
        }
     
     */


// MARK: - CoinModelElement
struct CoinModel: Codable {
    let id, symbol, name: String?
    let image: String?
    let currentPrice: Double?
    let marketCap, marketCapRank: Int?
    let fullyDilutedValuation: Int?
    let totalVolume: Int?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H, marketCapChangePercentage24H, circulatingSupply: Double?
    let totalSupply, maxSupply: Double?
    let ath, athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let roi: Roi?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(for amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, roi: roi, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingValue: Double {
        return (currentHoldings ?? 0) * (currentPrice ?? 0)
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

// MARK: - Roi
struct Roi: Codable {
    let times: Double?
    let currency: Currency?
    let percentage: Double?
}

enum Currency: String, Codable {
    case btc = "btc"
    case eth = "eth"
    case usd = "usd"
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}


