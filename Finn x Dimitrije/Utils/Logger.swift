//
//  Logger.swift
//  Finn x Dimitrije
//
//  Created by Dimitrije Pesic on 01/04/2023.
//

import Foundation

class Logger {
    
    enum LogType {
        case info
        case critical
        case warning
        case error
    }
    
    static func log(_ text: String, type: LogType = .info) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SS"
        let time = dateFormatter.string(from: Date())
        let logText = "\(type.icon) \(time) – \(text)"
        print(logText)
    }
}

extension Logger.LogType {
    var icon: Character {
        switch self {
        case .error:
            return "😵"
        case .info:
            return "💁🏻"
        case .critical:
            return "🔥"
        case .warning:
            return "⚠️"
        }
    }
}

