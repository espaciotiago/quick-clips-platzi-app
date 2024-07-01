//
//  ClipCardViewModelTest.swift
//  QuickClipsTests
//
//  Created by Tiago on 1/07/24.
//

import XCTest
@testable import QuickClips

final class ClipCardViewModelTest: XCTestCase {
    
    func testImageUrl() {
        let sut = self.createViewModel()
        XCTAssertEqual(sut.imageUrl, "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200")
    }
    
    func testUserClip() {
        let sut = self.createViewModel()
        XCTAssertEqual(sut.userClip.id, 1)
        XCTAssertEqual(sut.userClip.name, "Jhon Doe")
        XCTAssertEqual(sut.userClip.profileUrl, "https://www.pexels.com/@digitech")
    }
    
    // MARK: - Helpers
    private func createViewModel() -> ClipCardViewModel {
        return ClipCardViewModel(clip: Clip(id: 0,
                                            imageUrl: "https://images.pexels.com/videos/1526909/free-video-1526909.jpg?auto=compress&cs=tinysrgb&fit=crop&h=630&w=1200",
                                            videoUrl: "https://videos.pexels.com/video-files/1526909/1526909-hd_1280_720_24fps.mp4",
                                            user: UserClip(id: 1,
                                                           name: "Jhon Doe",
                                                           profileUrl: "https://www.pexels.com/@digitech")))
    }
}
