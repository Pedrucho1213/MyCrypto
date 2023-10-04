//
//  ViewCryptoControllerViewModel.swift
//  MyPerfectJob
//
//  Created by Pedro Miguel Pérez Torres on 27/09/23.
//

import Foundation
import UIKit

class ViewCryptoControllerViewModel {
    
    // MARK: - Variables
    var onImageLoaded: ((UIImage?)->Void)
    
    let coin: Coin

    // MARK: - Initializer
    init(_ coin: Coin) {
        self.coin = coin
        self.onImageLoaded = { _ in }
        loadImage()
    }
    
    private func loadImage(){
        coin.fetchLogo { [weak self] (image) in
            DispatchQueue.main.async {
                self?.onImageLoaded(image)
            }
        }
    }
    
    // MARK: - Computed Properties
    var rankLabel: String {
        return "Rank: \(self.coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(self.coin.pricingData.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(self.coin.pricingData.CAD.market_cap) CAD"
    }
    
    var maxSupplyLabel: String {
        
        if let max_supply = coin.maxSupply {
            return "Max Supplyu: \(max_supply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n"
        }
        
    }
    
}
