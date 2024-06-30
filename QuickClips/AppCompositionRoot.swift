//
//  AppCompositionRoot.swift
//  QuickClips
//
//  Created by Santiago Moreno on 30/06/24.
//

import Foundation

struct AppCompositionRoot {
    
    static let shared = AppCompositionRoot()
    
    let getClipsUseCase: GetClipsUseCaseProtocol
    
    init() {
        let networkingRequestService = NetworkingRequestService()
        let remoteDataSource = GetClipsRemoteDataSource(service: networkingRequestService)
        let localDataSource = GetClipsLocalDataSource()
        let networkMonitor = NetworkMonitor()
        self.getClipsUseCase = GetClipsUseCase(remoteDataSource: remoteDataSource,
                                               localDataSource: localDataSource,
                                               networkMonitor: networkMonitor)
    }
}
