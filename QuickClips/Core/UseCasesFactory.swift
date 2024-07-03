//
//  UseCasesFactory.swift
//  QuickClips
//
//  Created by Santiago Moreno on 1/07/24.
//

import Foundation

struct UseCasesFactory {
    
    var getClipsUseCase: GetClipsUseCaseProtocol {
        if Configuration.enviroment == .uiTest {
            let uiRemoteDataSource = GetClipsUITestingDataSource()
            let uiLocalDataSource = GetClipsLocalDataSource()
            let uiNetworkMonitor = UITestNetworkMonitor()
            return GetClipsUseCase(remoteDataSource: uiRemoteDataSource,
                                   localDataSource: uiLocalDataSource,
                                   networkMonitor: uiNetworkMonitor)
        } else {
            let networkingRequestService = NetworkingRequestService()
            let remoteDataSource = GetClipsRemoteDataSource(service: networkingRequestService)
            let localDataSource = GetClipsLocalDataSource()
            let networkMonitor = NetworkMonitor()
            return GetClipsUseCase(remoteDataSource: remoteDataSource,
                                   localDataSource: localDataSource,
                                   networkMonitor: networkMonitor)
        }
    }
    
    var cacheLatestClipsUseCase: CacheLatestClipsUseCase {
        if Configuration.enviroment == .uiTest {
            let uiCacheLatestClipsDataSource = CacheLatestClipsUITestingDataSource()
            return CacheLatestClipsUseCase(localCacheLatestClipsDataSource: uiCacheLatestClipsDataSource)
        } else {
            let localCacheLatestClipsDataSource = LocalCacheLatestClipsDataSource()
            return CacheLatestClipsUseCase(localCacheLatestClipsDataSource: localCacheLatestClipsDataSource)
        }
    }
}
