//
//  NetworkError.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidJson
    case invalidData
    case invalidUrl
    case noNetwork
}
