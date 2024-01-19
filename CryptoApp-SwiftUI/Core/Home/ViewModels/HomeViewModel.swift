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
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed
        case holdings, holdingsReversed
        case price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates all coins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnCoins in
                self?.allCoins = returnCoins
            }
            .store(in: &cancellables)
        
        // updates portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map (mapAllCoinsToPortfoliCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map (mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistic = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
    }
    
    func updatePortfolio(to coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(to: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins (text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice! > $1.currentPrice!})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice! < $1.currentPrice!})
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingValue > $1.currentHoldingValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingValue < $1.currentHoldingValue})
        default:
            return coins
        }
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
    
    private func mapAllCoinsToPortfoliCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(for: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volum", value: data.valume)
        let btcDominance = StatisticModel(title: "BTC Dominance ", value: data.btcDominance)
        
        let portfoiloValue = portfolioCoins.map({$0.currentHoldingValue}).reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingValue
            let percentChange = coin.priceChangePercentage24H! / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
            .reduce(0, +)
        
        let percentageChange = ((portfoiloValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfoiloValue.asCurrnecyWith2Decimals(), percentageChange: percentageChange)

        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats

    }
}
