//
//  CacheLatestClipsUseCaseTest.swift
//  QuickClipsTests
//
//  Created by Santiago Moreno on 1/07/24.
//

import XCTest
@testable import QuickClips

final class CacheLatestClipsUseCaseTest: XCTestCase {
    
    func testCacheLatestClips() {
        let sut = self.createUseCase()
        let exp = expectation(description: "testCacheLatestClips")
        var cached = false
        sut.execute([]) { completed in
            cached = completed
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertTrue(cached)
    }
    
    func testCacheLatestClipsError() {
        let sut = self.createUseCase(cacheCompleted: false)
        let exp = expectation(description: "testCacheLatestClipsError")
        var cached = false
        sut.execute([]) { completed in
            cached = completed
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertFalse(cached)
    }
    
    // MARK: - Helpers
    private func createUseCase(cacheCompleted: Bool = true) -> CacheLatestClipsUseCase {
        let localCacheLatestClipsDataSource = CacheLatestClipsUnitTestingDataSource(cacheCompleted: cacheCompleted)
        return CacheLatestClipsUseCase(localCacheLatestClipsDataSource: localCacheLatestClipsDataSource)
    }
}
