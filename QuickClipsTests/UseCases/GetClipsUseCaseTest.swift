//
//  GetClipsUseCaseTest.swift
//  QuickClipsTests
//
//  Created by Tiago on 1/07/24.
//

import XCTest
@testable import QuickClips

final class GetClipsUseCaseTest: XCTestCase {
    
    func testGetClips() {
        
    }
    
    func testGetClipsNoConnection() {
        
    }
    
    func testGetClipsWithError() {
        
    }
    
    func testGetClipsEmpty() {
        
    }
    
    // MARK: - Helpers
    private func createUseCase(remoteError: Error? = nil,
                               localError: Error? = nil,
                               remoteCustomFeed: [Clip]? = nil,
                               localCustomFeed: [Clip]? = nil,
                               hasConnection: Bool = true) -> GetClipsUseCase {
        
        let remoteDataSource = GetClipsUnitTestingDataSource(error: remoteError, feed: remoteCustomFeed)
        let localDataSource = GetClipsUnitTestingDataSource(isRemote: false, error: localError, feed: localCustomFeed)
        let networkMonitor = UnitTestNetworkMonitor(hasConnection: hasConnection)
        return GetClipsUseCase(remoteDataSource: remoteDataSource,
                               localDataSource: localDataSource,
                               networkMonitor: networkMonitor)
    }
}
