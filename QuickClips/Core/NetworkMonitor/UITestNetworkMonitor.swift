//
//  UITestNetworkMonitor.swift
//  QuickClips
//
//  Created by Santiago Moreno on 1/07/24.
//

import Foundation

struct UITestNetworkMonitor: CheckConnectionProtocol {
    
    func checkConnection() async -> Bool {
        return true
    }
}
