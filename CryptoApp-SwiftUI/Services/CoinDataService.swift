//
//  CoinDataService.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 17.01.2024.
//

import Combine
import Foundation

class CoinDataService {
    
    private let networking: NetworkingManager
    
    @Published var allCoins = [CoinModel]()
    var coinSubsscription: AnyCancellable?
    
    init(networking: NetworkingManager) {
        self.networking = networking
        getCoins()
    }
    
    
    func getCoins() {
        guard let url = URL(string: "   https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en") else { return }
        
        coinSubsscription = networking.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: networking.handleCompletion,
                  receiveValue: { [weak self] returnCoins in
                self?.allCoins = returnCoins
                self?.coinSubsscription?.cancel()
            })
    }
}
