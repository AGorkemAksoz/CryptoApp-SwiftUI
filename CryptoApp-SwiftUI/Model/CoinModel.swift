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
           "id":"bitcoin",
           "symbol":"btc",
           "name":"Bitcoin",
           "image":"https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
           "current_price":43117,
           "market_cap":845071015338,
           "market_cap_rank":1,
           "fully_diluted_valuation":905425146566,
           "total_volume":19560355807,
           "high_24h":43313,
           "low_24h":42219,
           "price_change_24h":453.23,
           "price_change_percentage_24h":1.06232,
           "market_cap_change_24h":9437583247,
           "market_cap_change_percentage_24h":1.12939,
           "circulating_supply":19600175.0,
           "total_supply":21000000.0,
           "max_supply":21000000.0,
           "ath":69045,
           "ath_change_percentage":-37.55431,
           "ath_date":"2021-11-10T14:24:11.849Z",
           "atl":67.81,
           "atl_change_percentage":63483.71775,
           "atl_date":"2013-07-06T00:00:00.000Z",
           "roi":null,
           "last_updated":"2024-01-16T13:00:47.766Z",
           "sparkline_in_7d":{
              "price":[
                 46291.51222544441,
                 46850.62305126942,
                 46582.7344868979,
                 46912.018102602466,
                 46932.086368230106,
                 46806.0321359157,
                 46635.6662538745,
                 46865.975970359825,
                 46616.472462636906,
                 45415.897838606754,
                 46306.9392339082,
                 46141.0273060772,
                 45906.06887155878,
                 45939.259761930414,
                 45950.313301301125,
                 46111.48372135452,
                 45952.15946645022,
                 45987.496154178545,
                 46027.177986635215,
                 45792.75131463303,
                 45369.25473142742,
                 45679.30564246095,
                 45590.52406586656,
                 45479.27153522809,
                 44684.81864350586,
                 45163.47550511835,
                 44869.51619645116,
                 45467.6133572863,
                 45392.622194144125,
                 46453.97725062231,
                 46513.81466983131,
                 46511.14453394796,
                 46078.25968508527,
                 45853.9558535854,
                 46934.634572964234,
                 46632.31314804979,
                 46725.54309792355,
                 46519.79254173459,
                 46616.62304903666,
                 46469.15146114308,
                 46433.607811226466,
                 46129.1605134834,
                 45883.34815509798,
                 46103.12576087745,
                 46299.968279201006,
                 46238.272786511865,
                 46864.651092302935,
                 47100.21009651497,
                 47463.81450104777,
                 47323.27894613025,
                 48494.622608035934,
                 46726.97584697682,
                 45962.76893619485,
                 46391.61108734224,
                 46548.9279345099,
                 46702.39311031018,
                 46128.48699055168,
                 46141.899557215744,
                 46433.7135397208,
                 46368.73796928371,
                 46355.166739373686,
                 46175.025128523965,
                 46102.678346513036,
                 46074.26890318738,
                 45909.2292601055,
                 46203.895660012866,
                 46139.41480725578,
                 46007.99930206061,
                 45842.02365041594,
                 45927.066290360795,
                 46110.06506169766,
                 45972.599684783585,
                 45891.671730129965,
                 45811.741190577406,
                 45506.38701813874,
                 44404.38946733802,
                 43413.265939278885,
                 43566.38237421859,
                 43577.38563709523,
                 43425.90555959927,
                 43669.16611568363,
                 43429.23924893638,
                 42449.031592594685,
                 42893.92960550481,
                 42810.836828553925,
                 42636.96114574562,
                 42620.00689292529,
                 42603.522769457115,
                 42834.21512509032,
                 43097.34963950681,
                 43156.04413567984,
                 43110.82636184149,
                 43194.611850561865,
                 42924.06682416366,
                 42787.447482294534,
                 42620.73810818898,
                 42691.75401835534,
                 42727.83875284763,
                 42769.239279800146,
                 43107.161095413874,
                 42839.17992906548,
                 42877.01078287877,
                 42801.10412018963,
                 42799.45958566227,
                 42848.850175774875,
                 42965.74097370059,
                 42961.7203495467,
                 42848.47451640749,
                 42697.81035924758,
                 42778.29903610591,
                 42757.98342959938,
                 42675.56001761096,
                 42562.31132663897,
                 42704.64363545284,
                 42984.370023795724,
                 42953.296040174224,
                 43000.279740181286,
                 42946.26645181208,
                 42890.12463639017,
                 42817.99980499583,
                 42739.77447179521,
                 42900.62935751003,
                 42919.11390786829,
                 42901.19652700834,
                 42910.8551094731,
                 42970.37989439881,
                 42912.59869673776,
                 42673.61970251325,
                 42507.76890096498,
                 42442.088434188234,
                 42279.079271689065,
                 41753.68155974889,
                 42226.0482506253,
                 42242.652522430864,
                 42358.46495312003,
                 42520.55498117203,
                 42567.442340384805,
                 42736.27916799869,
                 42640.98001402418,
                 42704.12550087481,
                 42677.56569785656,
                 42712.71391926351,
                 42546.22079252131,
                 42673.55848288864,
                 42635.881490202904,
                 42824.959051230086,
                 42219.41657918872,
                 42257.148664380176,
                 42516.25075282865,
                 42692.42700720438,
                 42954.24288046856,
                 42905.29339904443,
                 42865.9823090945,
                 42772.365018332785,
                 42570.85110583026,
                 42587.336038354406,
                 42595.618405364774,
                 42536.700178525374,
                 42703.74954670219,
                 42876.80876440539,
                 42743.33357705546,
                 42746.23254955701,
                 42703.42448359616,
                 42709.53723335667,
                 42980.54149665972,
                 42906.665844896015,
                 42843.67445578118,
                 42824.21651204008
              ]
           },
           "price_change_percentage_24h_in_currency":1.062323633991737
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


