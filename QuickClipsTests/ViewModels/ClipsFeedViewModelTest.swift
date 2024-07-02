//
//  ClipsFeedViewModelTest.swift
//  QuickClipsTests
//
//  Created by Santiago Moreno on 1/07/24.
//

import XCTest
@testable import QuickClips

final class ClipsFeedViewModelTest: XCTestCase {
    
    func testShouldShowEmptyView() async {
        let sut = self.createViewModel(remoteCustomFeed: [])
        await sut.getFeed()
        XCTAssertTrue(sut.shouldShowEmptyView)
    }
    
    func testGetFeed() async {
        let sut = self.createViewModel()
        await sut.getFeed()
        XCTAssertFalse(sut.feed.isEmpty)
        XCTAssertFalse(sut.showingFromCache)
        XCTAssertEqual(sut.page, 2)
        XCTAssertNil(sut.error)
        
        let sutNoConnection = self.createViewModel(hasConnection: false)
        await sutNoConnection.getFeed()
        XCTAssertFalse(sutNoConnection.feed.isEmpty)
        XCTAssertTrue(sutNoConnection.showingFromCache)
        XCTAssertEqual(sutNoConnection.page, 1)
        XCTAssertNil(sutNoConnection.error)
    }
    
    func testGetFeedError() async {
        let sut = self.createViewModel(remoteError: NSError(domain: "Test error", code: 0))
        await sut.getFeed()
        XCTAssertTrue(sut.feed.isEmpty)
        XCTAssertNotNil(sut.error)
    }
    
    func testIsLastLoadedClip() async {
        let clip = Clip(id: 9,
                        imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                        videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                        user: UserClip(id: 1,
                                       name: "Remote Doe",
                                       profileUrl: "https://www.pexels.com/@digitech"))
        let clip2 = Clip(id: 1,
                         imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                         videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                         user: UserClip(id: 1,
                                        name: "Remote Doe",
                                        profileUrl: "https://www.pexels.com/@digitech"))
        let sut = self.createViewModel()
        await sut.getFeed()
        XCTAssertTrue(sut.isLastLoadedClip(clip))
        XCTAssertFalse(sut.isLastLoadedClip(clip2))
    }
    
    func testSelectClip() {
        let clip = Clip(id: 9,
                        imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                        videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                        user: UserClip(id: 1,
                                       name: "Remote Doe",
                                       profileUrl: "https://www.pexels.com/@digitech"))
        let sut = self.createViewModel()
        sut.selectClip(clip)
        XCTAssertNotNil(sut.selectedClip)
    }
    
    func testShowProfileUrl() {
        let sut = self.createViewModel()
        sut.showProfileUrl(URL(string: "https://www.pexels.com/@digitech"))
        XCTAssertEqual(sut.sheet, .safariView(url: URL(string: "https://www.pexels.com/@digitech")!))
    }
    
    // MARK: - Helper
    private func createViewModel(remoteError: Error? = nil,
                                 localError: Error? = nil,
                                 remoteCustomFeed: [Clip]? = nil,
                                 localCustomFeed: [Clip]? = nil,
                                 hasConnection: Bool = true,
                                 cacheCompleted: Bool = true) -> ClipsFeedViewModel {
        
        let remoteDataSource = GetClipsUnitTestingDataSource(error: remoteError, feed: remoteCustomFeed)
        let localDataSource = GetClipsUnitTestingDataSource(isRemote: false, error: localError, feed: localCustomFeed)
        let networkMonitor = UnitTestNetworkMonitor(hasConnection: hasConnection)
        let localCacheLatestClipsDataSource = CacheLatestClipsUnitTestingDataSource(cacheCompleted: cacheCompleted)
        
        let getClipsUseCase = GetClipsUseCase(remoteDataSource: remoteDataSource,
                                              localDataSource: localDataSource,
                                              networkMonitor: networkMonitor)
        let cacheLatestClipsUseCase = CacheLatestClipsUseCase(localCacheLatestClipsDataSource: localCacheLatestClipsDataSource)
        
        return ClipsFeedViewModel(getClipsUseCase: getClipsUseCase,
                                  cacheLatestClipsUseCase: cacheLatestClipsUseCase)
    }
}
