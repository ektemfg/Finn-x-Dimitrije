//
//  DataService.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import Foundation

class DataService: ObservableObject {
    
    static var shared: DataService = {
        DataService()
    }()
    
    func fetchAds(completionHandler: @escaping (Result<AdResponse, Error>) -> Void) {
        let url = Endpoints.data.url!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                Logger.log("Could not fetch from \(url.description)", type: .error)
                completionHandler(.failure(NetworkError.invalidUrl))
                return
            }
            do {
                let decoder = JSONDecoder()
                let adResponse = try decoder.decode(AdResponse.self, from: data)
                completionHandler(.success(adResponse))
            } catch {
                Logger.log("Could not decode JSON", type: .error)
                Logger.log(error.localizedDescription, type: .error)
                print(error)
                completionHandler(.failure(NetworkError.invalidJson))
            }
            
        }
        task.resume()
    }
    
}
