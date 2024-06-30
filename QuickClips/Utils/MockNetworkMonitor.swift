//
//  MockNetworkMonitor.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct MockNetworkMonitor: CheckConnectionProtocol {
    
    let hasConnection: Bool
    
    init(hasConnection: Bool = true) {
        self.hasConnection = hasConnection
    }
    
    func checkConnection() async -> Bool {
        return self.hasConnection
    }
}
