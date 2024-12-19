//
//  HomeViewModel.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 8/11/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title", value: "Value", percentagetChange: 1),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value"),
        StatisticModel(title: "Title", value: "Value", percentagetChange: -7)
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    private let portfolioDataService = PortfolioDataService()
    
    
    private let dataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables  = Set<AnyCancellable>()
    
    
    
    init(){
        addSubcriber()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//            self.portfolioCoins.append(DeveloperPreview.instance.coin)
//        }
    }
    
    func addSubcriber(){
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //update market data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink{ [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
            // update portfolio coin
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntites) -> [CoinModel] in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntites.first(where: {$0.coinID == coin.id}) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    func updatePorfolio(coin: CoinModel, amount: Double) {
        
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        // parse lowercase
        
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentagetChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value:"$0.00", percentagetChange: 0)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance
        ])
        return stats
    }
    
}
