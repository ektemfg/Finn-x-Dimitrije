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
    @Published var adList: [Ad] = []
    @Published var isLoading: Bool = false
    @Published var fetchedAllAds: Bool = false
    private var totalNumberOfAds: Int = 1
    
    
    
    func goFetchAds() {
        if isLoading {
            Logger.log("Fetching ads from the API.", type:.warning)
        }
        guard !fetchedAllAds else {
            Logger.log("All ads are fetched", type: .warning)
            return
        }
        self.fetchAds() { result in
            switch result {
            case .success(let response):
                self.totalNumberOfAds = response.size
                self.adList = response.items
                self.fetchedAllAds = self.adList.count >= self.totalNumberOfAds
            case .failure(let error):
                Logger.log(error.localizedDescription, type: .error)
            }
            self.isLoading = false
        }
    }
    
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
                Logger.log("Could not decode JSON)", type: .error)
                completionHandler(.failure(NetworkError.invalidJson))
            }
            
        }
        task.resume()
    }
    
}
