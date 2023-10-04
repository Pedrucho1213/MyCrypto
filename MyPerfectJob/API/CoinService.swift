//
//  CoinService.swift
//  MyPerfectJob
//
//  Created by Pedro Miguel Pérez Torres on 03/10/23.
//

import Foundation

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsins server response.")
}

class CoinService {
    
    static func fetchCoins(with endpoint: EndPoint, completion: @escaping (Result<[Coin], CoinServiceError>)->Void){
        guard let request = endpoint.request else {return}
        
        URLSession.shared.dataTask(with: request){data, resp, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {

                do{
                    
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                    
                }catch let err{
                    completion(.failure(.unknown()))
                    print(err.localizedDescription)
                }
                
            }
            
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    completion(.success(coinData.data))
                } catch let err {
                    completion(.failure(.decodingError(err.localizedDescription)))
                    print(err.localizedDescription)
                }
            }else{
                completion(.failure(.unknown()))
            }
        }.resume()
    }
}
