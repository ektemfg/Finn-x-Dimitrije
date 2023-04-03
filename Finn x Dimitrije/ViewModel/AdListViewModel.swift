//
//  AdListViewModel.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import SwiftUI

enum FavouriteOperation {
    case addFavorite
    case removeFavorite
    case clearFavorites
}

class AdListViewModel: ObservableObject {
    @Published var favsOnly: Bool = false
    @Published var onlyOffline: Bool = false
    let dataService = DataService.shared
    @Published var adList: [Ad] = []
    @Published var favAdList: [Ad] = []
    @Published var isLoading: Bool = false
    @Published var fetchedAllAds: Bool = false
    private var isAdsLoaded: Bool = false
    private var totalNumberOfAds: Int = 1
    var favoriteAds: Set<String> = []
    
    init() {
        self.goFetchAds()
        self.loadAds()
    }
    
    static let shared = AdListViewModel()
    
    func goFetchAds() {
        if isLoading {
            Logger.log("Fetching ads from the API.", type:.info)
        }
        guard !fetchedAllAds else {
            Logger.log("All ads are fetched", type: .warning)
            return
        }
        if NetworkChecker.isDeviceConnectedToNetwork() {
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
        } else {
            Logger.log("Device is offline🥶, trying to fetch favorites from UserDefaults", type:.critical)
            let defaults = UserDefaults.standard
                    if let data = defaults.data(forKey: "backupPlanFavorites"),
                       let ads = try? JSONDecoder().decode([Ad].self, from: data) {
                        self.adList = ads
                        self.favAdList = ads
                        self.fetchedAllAds = true
                    }
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.onlyOffline = true
                        self.isAdsLoaded = true
                    }
            
        }
    }
    
    func userDefaultsOperation(_ operation: FavouriteOperation, ad: Ad?) {
        switch operation {
        case .addFavorite:
            guard ad != nil else {
                Logger.log("Tried to add invalid ad as Favourite.")
                return
            }
            self.favoriteAds.insert(ad!.id)
            saveFavoriteAds()
        case .removeFavorite:
            guard ad != nil else {
                Logger.log("Tried to remove invalid ad from Favourites.")
                return
            }
            self.favoriteAds.remove(ad!.id)
            self.favAdList.removeAll(where: { $0.id == ad!.id})
            
            saveFavoriteAds()
        case .clearFavorites:
            self.favoriteAds.removeAll()
            self.favAdList.removeAll()
            clearFavoriteAds()
        }
    }
      
      private func saveFavoriteAds() {
          Logger.log("Saving Favorites to UserDefaults.", type: .info)
          UserDefaults.standard.set(Array(favoriteAds), forKey: "favoriteAds")
          loadAds()
      }
      
      private func clearFavoriteAds() {
          Logger.log("Removing all Favorites from UserDefaults.", type: .info)
          UserDefaults.standard.removeObject(forKey: "favoriteAds")
          UserDefaults.standard.removeObject(forKey: "backupPlanFavorites")
      }
    
     func loadAds() {
         guard !isAdsLoaded else {
             return
         }
        do {
            Logger.log("Loading Favorites from UserDefaults.", type: .info)
            if let savedIds = UserDefaults.standard.array(forKey: "favoriteAds") as? [String] {
                self.favoriteAds = Set(savedIds)
                setAdsList()
            } else {
                throw AppError.invalidUserDefaults
            }
        } catch let error {
            Logger.log("Error loading Favorites from UserDefaults: \(error.localizedDescription)", type: .error)
        }
    }
    
    private func setAdsList() {
        do {
            Logger.log("Finding Ads that contain saved ids...", type:.info)
            let favAdIds = Set(favoriteAds)
            let adsToAdd = adList.filter { favAdIds.contains($0.id) }
            DispatchQueue.main.async {
                self.favAdList = adsToAdd
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(adsToAdd) {
                    let defaults = UserDefaults.standard
                    Logger.log("Saving favorites for offline use to UserDefaults",type:.info)
                    defaults.set(encoded, forKey: "backupPlanFavorites")
                }
            }
        }
    }



     func favsContainsAd(ad: Ad) -> Bool {
        var result: Bool = false
        do {
            if let savedIds = UserDefaults.standard.array(forKey: "favoriteAds") as? [String] {
                result = savedIds.contains(ad.id)
            } else {
                throw AppError.invalidUserDefaults
            }

        } catch let error {
            Logger.log("Error loading Favorites from UserDefaults: \(error.localizedDescription)", type: .error)
        }
        return result
    }


  
}
