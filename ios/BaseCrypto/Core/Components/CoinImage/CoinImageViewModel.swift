//
//  CoinImageViewModel.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 9/11/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var loading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancelables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubcriber()
        self.loading = true
    }
    
    
    private func addSubcriber(){
        
        dataService.$image
            .sink { [weak self] (_) in
                self?.loading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancelables)

    }
}
