//
//  MarketDataService.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 18.01.2024.
//

import Combine
import Foundation

class MarketDataService {
    
    private let networking: NetworkingManager
    
    @Published var marketData : MarketDataModel? = nil
    var marketDataSubsscription: AnyCancellable?
    
    init(networking: NetworkingManager) {
        self.networking = networking
        getData()
    }
    
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubsscription = networking.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: networking.handleCompletion,
                  receiveValue: { [weak self] returnedData in
                self?.marketData = returnedData.data
                self?.marketDataSubsscription?.cancel()
            })
    }
}
