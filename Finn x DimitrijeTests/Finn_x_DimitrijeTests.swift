//
//  Finn_x_DimitrijeTests.swift
//  Finn x DimitrijeTests
//
//  Created by Dimitrije Pesic on 31/03/2023.
//

import XCTest
@testable import Finn_x_Dimitrije

final class AdListViewModelTests: XCTestCase {
    
    var viewModel: AdListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = AdListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialValues() {
        if NetworkChecker.isDeviceConnectedToNetwork() == true {
            XCTAssertEqual(viewModel.favsOnly, false)
            XCTAssertEqual(viewModel.onlyOffline, false)
            XCTAssertEqual(viewModel.isLoading, false)
            XCTAssertEqual(viewModel.fetchedAllAds, false)
            XCTAssertEqual(viewModel.favoriteAds, [])
        } else {
            XCTAssertEqual(viewModel.favsOnly, false)
            XCTAssertEqual(viewModel.onlyOffline, true)
            XCTAssertEqual(viewModel.isLoading, false)
            XCTAssertEqual(viewModel.fetchedAllAds, false)
            XCTAssertEqual(viewModel.favoriteAds, [])
        }
    }
    
    func testGoFetchAds() {
        let expectation = XCTestExpectation(description: "Fetch ads")
        
        viewModel.goFetchAds()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            // Check values after 5 seconds (change this value as needed)
            XCTAssertTrue(!self.viewModel.isLoading)
            XCTAssertTrue(!self.viewModel.adList.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadAds() {
        // Teste setting av mockFavoriter i userDefaults og loading via loadAds()
        let mockFavorites = ["1", "2", "3"]
        UserDefaults.standard.set(mockFavorites, forKey: "favoriteAds")
        viewModel.loadAds()
        XCTAssertEqual(viewModel.favoriteAds, Set(mockFavorites))
    }
    
    func testUserDefaultsOperations() {
        // Teste UserDefaults funksjonen - add / remove delene.
        let mockAd = Ad(id: "1", description: "Fin Bok", url: "/2023/lol.jpg", adType: .b2B, location: "Stavanger", type: .ad, price: Price(value: 100, total: nil), image: AdImage(url: "2023/3/vertical-0/04/6/293/508/636_1678017296.jpg", height: 100, width: 100, type: .general, scalable: true), score: 0.70, favourite: Favourite(adId: "22", adType: "ad"), shippingOption: ShippingOption(label: .fiksFerdig))
        viewModel.userDefaultsOperation(.addFavorite, ad: mockAd)
        XCTAssertTrue(viewModel.favoriteAds.contains(mockAd.id))
        viewModel.userDefaultsOperation(.removeFavorite, ad: mockAd)
        XCTAssertFalse(viewModel.favoriteAds.contains(mockAd.id))


    }
    
    func testFavsContainsAd() {
        // Sjekke om funksjonen som sjekker om ad er favoritt funker
        let mockAd = Ad(id: "1", description: "Fin Bok", url: "/2023/lol.jpg", adType: .b2B, location: "Stavanger", type: .ad, price: Price(value: 100, total: nil), image: AdImage(url: "2023/3/vertical-0/04/6/293/508/636_1678017296.jpg", height: 100, width: 100, type: .general, scalable: true), score: 0.70, favourite: Favourite(adId: "22", adType: "ad"), shippingOption: ShippingOption(label: .fiksFerdig))
        viewModel.userDefaultsOperation(.addFavorite, ad: mockAd)
        XCTAssertTrue(viewModel.favsContainsAd(ad: mockAd))
        viewModel.userDefaultsOperation(.removeFavorite, ad: mockAd)
        XCTAssertFalse(viewModel.favsContainsAd(ad: mockAd))
    }
}
