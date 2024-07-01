//
//  NetworkMonitor.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation
import Network

struct NetworkMonitor: CheckConnectionProtocol {
    
    let networkMonitor = NWPathMonitor()
    
    func checkConnection() async -> Bool {
        return await withCheckedContinuation { continuation in
            let networkMonitor = NWPathMonitor()
            let queue = DispatchQueue.global(qos: .background)
            
            networkMonitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(returning: false)
                }
                networkMonitor.cancel()
            }
            
            networkMonitor.start(queue: queue)
        }
    }
}
