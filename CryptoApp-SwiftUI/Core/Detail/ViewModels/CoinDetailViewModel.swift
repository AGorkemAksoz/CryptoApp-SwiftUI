//
//  CoinDetailViewModel.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 19.01.2024.
//

import Combine
import Foundation


class CoinDetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .sink { returnCoinDetail in
                print("RECIEVED COIN DETAIL DATA")
                print(returnCoinDetail)
            }
            .store(in: &cancellables)
    }
}
