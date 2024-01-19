//
//  CoinDetailDataService.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 19.01.2024.
//

import Combine
import Foundation

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubsscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    
    func getCoinDetails() {
        print("GetCoinDetails")
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id!)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubsscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnCoinDetails) in
                print(returnCoinDetails)
                self?.coinDetails = returnCoinDetails
                self?.coinDetailSubsscription?.cancel()
            })
    }
}
