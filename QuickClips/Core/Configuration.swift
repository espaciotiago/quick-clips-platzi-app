//
//  Configuration.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

enum Enviroment: Equatable {
    case unitTest
    case uiTest
    case `default`
}

struct ConfigurationKeys {
    static let prexelsApiKey = "PREXELS_API_KEY"
}

struct Configuration {
    static var enviroment: Enviroment {
        let processInfo = ProcessInfo.processInfo
        if processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return .unitTest
        } else if processInfo.arguments.contains("UITesting") {
            return .uiTest
        } else {
            return .default
        }
    }
}
