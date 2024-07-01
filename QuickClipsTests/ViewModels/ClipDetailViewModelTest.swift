//
//  ClipDetailViewModelTest.swift
//  QuickClipsTests
//
//  Created by Santiago Moreno on 1/07/24.
//

import XCTest
@testable import QuickClips

final class ClipDetailViewModelTest: XCTestCase {
    
    func testUserClip() {
        let sut = self.createViewModel()
        XCTAssertEqual(sut.userClip.id, 1)
        XCTAssertEqual(sut.userClip.name, "Jhon Doe")
        XCTAssertEqual(sut.userClip.profileUrl, "https://www.pexels.com/@digitech")
    }
    
    func testLoadVideo() {
        let sut = self.createViewModel()
        sut.loadVideo()
        XCTAssertNotNil(sut.player)
    }
    
    func testShowProfileUrl() {
        let sut = self.createViewModel()
        sut.showProfileUrl(URL(string: "https://www.pexels.com/@digitech"))
        XCTAssertEqual(sut.sheet, .safariView(url: URL(string: "https://www.pexels.com/@digitech")!))
    }
    
    // MARK: - Helpers
    private func createViewModel() -> ClipDetailViewModel {
        let clip = Clip(id: 0,
                        imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                        videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                        user: UserClip(id: 1,
                                       name: "Jhon Doe",
                                       profileUrl: "https://www.pexels.com/@digitech"))
        return ClipDetailViewModel(clip: clip)
    }
}
