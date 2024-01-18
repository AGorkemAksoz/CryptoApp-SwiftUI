//
//  HomeViewModel.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 17.01.2024.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var statistic: [StatisticModel] = []
    @Published var allCoins = [CoinModel]()
    @Published var portfolioCoins = [CoinModel]()
    @Published var searchText : String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates all coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnCoins in
                self?.allCoins = returnCoins
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .map (mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistic = returnedStats
            }
            .store(in: &cancellables)
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModel] in
                
                coinModels
                    .compactMap { coin -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                            return nil
                        }
                        return coin.updateHoldings(for: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(to coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(to: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasetText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name!.lowercased().contains(lowercasetText) ||
            coin.symbol!.lowercased().contains(lowercasetText) ||
            coin.id!.lowercased().contains(lowercasetText)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volum", value: data.valume)
        let btcDominance = StatisticModel(title: "BTC Dominance ", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)

        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats

    }
}
