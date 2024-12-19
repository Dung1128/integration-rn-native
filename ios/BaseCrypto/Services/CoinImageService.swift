//
//  CoinImageService.swift
//  BaseCrypto
//
//  Created by Dũng Nguyễn on 9/11/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubcription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
   
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
//    private func getCoinImage(){
//        
//        print("Downloading image now!\(coin.id)")
//        
//        guard let url = URL(string: coin.name) else { return }
//        
//        imageSubcription = NetworkingManager.download(url: url)
//            .tryMap({ (data) -> UIImage? in
//                return UIImage(data:data)
//            })
//            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnImage) in
//                self?.image = returnImage
//                self?.imageSubcription?.cancel()
//            })
//        
//    }

    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("retrieved image from file manager")
        } else {
            downloadCoinImage()
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage(){
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubcription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data:data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnImage) in
                guard let self = self, let downloadedImage = returnImage else { return }
                self.image = downloadedImage
                self.imageSubcription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: imageName, folderName: folderName)
            })
        
    }
}
    
    
   
