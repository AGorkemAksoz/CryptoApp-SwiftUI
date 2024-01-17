//
//  CoinImageService.swift
//  CryptoApp-SwiftUI
//
//  Created by Gorkem on 17.01.2024.
//

import Combine
import Foundation
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocaleFileManager.shared
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id!
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImge = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImge
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image!) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedImage in
                guard let self = self,
                let downLoadedImage = returnedImage else { return }
                self.image = downLoadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downLoadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
