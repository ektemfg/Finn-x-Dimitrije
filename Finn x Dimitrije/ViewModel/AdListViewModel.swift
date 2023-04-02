//
//  AdListViewModel.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import SwiftUI

class AdListViewModel: ObservableObject {
    let dataService = DataService.shared
    @Published var adList: [Ad] = []
    @Published var isLoading: Bool = false
    @Published var fetchedAllAds: Bool = false
    private var totalNumberOfAds: Int = 1
    
    init() {
        self.goFetchAds()
    }
    
    func goFetchAds() {
        if isLoading {
            Logger.log("Fetching ads from the API.", type:.info)
        }
        guard !fetchedAllAds else {
            Logger.log("All ads are fetched", type: .warning)
            return
        }
        dataService.fetchAds() { result in
            switch result {
            case .success(let response):
                self.totalNumberOfAds = response.size
                DispatchQueue.main.async {
                    self.adList = response.items
                    self.fetchedAllAds = self.adList.count >= self.totalNumberOfAds
                }
            case .failure(let error):
                Logger.log(error.localizedDescription, type: .error)
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
