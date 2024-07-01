//
//  GetClipsUseCaseTest.swift
//  QuickClipsTests
//
//  Created by Tiago on 1/07/24.
//

import XCTest
@testable import QuickClips

final class GetClipsUseCaseTest: XCTestCase {
    
    func testGetClips() async {
        let sut = self.createUseCase()
        let result = try! await sut.execute(page: 1, limit: 10)
        var clips: [Clip]?
        var shouldCacheClips = false
        switch result {
        case .success(let response):
            clips = response.clips
            shouldCacheClips = response.shouldCacheClips
        default: ()
        }
        XCTAssertNotNil(clips)
        XCTAssertEqual(clips?.count, 10)
        XCTAssertTrue(shouldCacheClips)
    }
    
    func testGetClipsNoConnection() async {
        let sut = self.createUseCase(hasConnection: false)
        let result = try! await sut.execute(page: 1, limit: 10)
        var clips: [Clip]?
        var shouldCacheClips = false
        switch result {
        case .success(let response):
            clips = response.clips
            shouldCacheClips = response.shouldCacheClips
        default: ()
        }
        XCTAssertNotNil(clips)
        XCTAssertEqual(clips?.count, 10)
        XCTAssertFalse(shouldCacheClips)
    }
    
    func testGetClipsWithError() async {
        let sut = self.createUseCase(remoteError: NSError(domain: "Test Error", code: 0))
        let result = try! await sut.execute(page: 1, limit: 10)
        var error: Error?
        switch result {
        case .failure(let resultError):
            error = resultError
        default: ()
        }
        XCTAssertNotNil(error)
        
        let sutNoConnection = self.createUseCase(localError: NSError(domain: "Test Error", code: 0),
                                                 hasConnection: false)
        let resultNoConnection = try! await sutNoConnection.execute(page: 1, limit: 10)
        var errorNoConnection: Error?
        switch resultNoConnection {
        case .failure(let resultError):
            errorNoConnection = resultError
        default: ()
        }
        XCTAssertNotNil(errorNoConnection)
    }
    
    func testGetClipsEmpty() async {
        let sut = self.createUseCase(remoteCustomFeed: [])
        let result = try! await sut.execute(page: 1, limit: 10)
        var clips: [Clip]?
        var shouldCacheClips = false
        switch result {
        case .success(let response):
            clips = response.clips
            shouldCacheClips = response.shouldCacheClips
        default: ()
        }
        XCTAssertNotNil(clips)
        XCTAssertEqual(clips?.count, 0)
        XCTAssertTrue(shouldCacheClips)
        
        let sutNoConnection = self.createUseCase(localCustomFeed: [],
                                                 hasConnection: false)
        let resultNoConnection = try! await sutNoConnection.execute(page: 1, limit: 10)
        var clipsNoConnection: [Clip]?
        var shouldCacheClipsNoConnection = false
        switch resultNoConnection {
        case .success(let response):
            clipsNoConnection = response.clips
            shouldCacheClipsNoConnection = response.shouldCacheClips
        default: ()
        }
        XCTAssertNotNil(clipsNoConnection)
        XCTAssertEqual(clipsNoConnection?.count, 0)
        XCTAssertTrue(shouldCacheClipsNoConnection)
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
