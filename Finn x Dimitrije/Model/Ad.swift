//
//  Ad.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import Foundation

struct AdResponse: Codable {
    let items: [Ad]
    let size: Int
    let version: String
}

struct Ad: Codable {
    let id: String
    let description, url : String?
    let adType: AdType
    let location: String?
    let type: AdTypeEnum?
    let price: Price?
    let image: AdImage
    let score: Double?
    let favourite: Favourite?
    let shippingOption: ShippingOption?
    
    var hasShipping: Bool {
        return self.shippingOption != nil
    }
    
    var hoursSinceAdded: Int {
        switch self.adType{
        case .b2B :
            return 3
        case .bap:
            return 7
        case .realestate:
           return 12
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, description, url
        case adType = "ad-type"
        case location, type, price, image, score, favourite, shippingOption
    }
}

enum AdType: String, Codable {
    case b2B = "B2B"
    case bap = "BAP"
    case realestate = "REALESTATE"
}

enum AdTypeEnum: String, Codable {
    case ad = "AD"
}

enum AdImageType: String, Codable {
    case general = "GENERAL"
}

struct AdImage: Codable {
    let url: String
    let height, width: Int
    let type: AdImageType
    let scalable: Bool
}

struct Price: Codable {
    let value: Int
    let total: Int?
}

struct Favourite: Codable {
    let adId: String
    let adType: String
    
    enum CodingKeys: String, CodingKey {
        case adId = "itemId"
        case adType = "itemType"
    }
}

struct ShippingOption: Codable {
    let label: Label
}

enum Label: String, Codable {
case fiksFerdig = "Fiks ferdig"
}
