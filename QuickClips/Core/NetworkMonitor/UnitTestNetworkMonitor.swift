//
//  UnitTestNetworkMonitor.swift
//  QuickClips
//
//  Created by Tiago on 1/07/24.
//

import Foundation

struct UnitTestNetworkMonitor: CheckConnectionProtocol {
    
    let hasConnection: Bool
    
    init(hasConnection: Bool = true) {
        self.hasConnection = hasConnection
    }
    
    func checkConnection() async -> Bool {
        return self.hasConnection
    }
}
