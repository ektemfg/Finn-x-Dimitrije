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
    case loadFavorites
}

class AdListViewModel: ObservableObject {
    let dataService = DataService.shared
    @Published var adList: [Ad] = []
    @Published var favAdList: [Ad] = []
    @Published var isLoading: Bool = false
    @Published var fetchedAllAds: Bool = false
    private var totalNumberOfAds: Int = 1
    var favoriteAds: Set<String> = []
    
    init() {
        self.goFetchAds()
    }
    
    static var shared: AdListViewModel = {
        AdListViewModel()
    }()
    
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
    
    func userDefaultsOperation(_ operation: FavouriteOperation, ad: Ad?) {
          switch operation {
          case .addFavorite:
              guard ad != nil else {
                  Logger.log("Tried to add invalid ad as Favourite.")
                  return
              }
              favoriteAds.insert(ad!.id)
              saveFavoriteAds()
          case .removeFavorite:
              guard ad != nil else {
                  Logger.log("Tried to remove invalid ad from Favourites.")
                  return
              }
              favoriteAds.remove(ad!.id)
              favAdList.removeAll(where: { $0.id == ad!.id})
              saveFavoriteAds()
          case .clearFavorites:
              favoriteAds.removeAll()
              favAdList.removeAll()
              clearFavoriteAds()
          case .loadFavorites:
              favoriteAds.removeAll()
              loadAds()
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
      }
    
    private func loadAds() {
        do {
            Logger.log("Loading Favorites to UserDefaults.", type: .info)
            if let savedIds = UserDefaults.standard.array(forKey: "favoriteAds") as? [String] {
                let favoriteAds = adList.filter { savedIds.contains($0.id) }
                self.favAdList = favoriteAds
            } else {
                throw AppError.invalidUserDefaults
            }
        } catch let error {
            Logger.log("Error loading Favorites from UserDefaults: \(error.localizedDescription)", type: .error)
        }
    }


  
}
