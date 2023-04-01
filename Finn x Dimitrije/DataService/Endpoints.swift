//
//  FinnEndpoint.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import Foundation

enum Endpoints {
    private static let dataEndpoint = "https://gist.githubusercontent.com/baldermork/6a1bcc8f429dcdb8f9196e917e5138bd/raw/"
    private static let imageEndpoint = "https://images.finncdn.no/dynamic/480x360c/"
    
    case data
    case image(url: String)
    
    private var path: String {
        switch self {
        case .data :
            return "discover.json"
        case .image(let url) :
            return url
        }
    }
    
    var url: URL? {
        switch self {
        case .data :
            return URL(string: Endpoints.dataEndpoint + path)
        case .image(_) :
            return URL(string: Endpoints.imageEndpoint + path)
        }
       
    }
}
