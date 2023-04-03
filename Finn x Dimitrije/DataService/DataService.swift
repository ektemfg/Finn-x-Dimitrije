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
        Task {
            do {
                let adResponse = try await fetchAdsAsync()
                completionHandler(.success(adResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchAdsAsync() async throws -> AdResponse {
        let url = Endpoints.data.url!
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AppError.invalidUrl
        }
        let decoder = JSONDecoder()
        let adResponse = try decoder.decode(AdResponse.self, from: data)
        return adResponse
    }


    
}
