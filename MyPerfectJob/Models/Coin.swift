//
//  Coin.swift
//  MyPerfectJob
//
//  Created by Pedro Miguel Pérez Torres on 22/09/23.
//

import Foundation
import UIKit

struct CoinArray: Decodable {
    let data: [Coin]
}

struct Coin: Decodable {
    let id: Int
    let name: String
    let maxSupply: Int?
    let rank: Int
    let pricingData: PricingData
    
    var logoUrl: URL?{
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case maxSupply = "max_supply"
        case rank = "cmc_rank"
        case pricingData = "quote"
    }
    
    func fetchLogo(completion: @escaping (UIImage?) -> Void){
        guard let url = logoUrl else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data:data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
}

struct PricingData: Decodable {
    let CAD: CAD
}

struct CAD: Decodable {
    let price: Double
    let market_cap: Double
}
