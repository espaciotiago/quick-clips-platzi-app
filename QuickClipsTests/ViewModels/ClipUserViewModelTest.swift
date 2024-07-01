//
//  ClipUserViewModelTest.swift
//  QuickClipsTests
//
//  Created by Santiago Moreno on 1/07/24.
//

import XCTest
@testable import QuickClips

final class ClipUserViewModelTest: XCTestCase {
    
    func testName() {
        let sut = self.createViewModel()
        XCTAssertEqual(sut.name, "Jhon Doe")
    }
    
    func testProfileUrl() {
        let sut = self.createViewModel()
        let url = URL(string: "https://www.pexels.com/@digitech")
        XCTAssertEqual(sut.profileUrl, url)
    }
    
    func testProfileImageUrl() {
        let sut = self.createViewModel()
        XCTAssertEqual(sut.profileImageUrl, "https://ui-avatars.com/api/?name=Jhon+Doe")
    }
    
    // MARK: - Helpers
    private func createViewModel() -> ClipUserViewModel {
        return ClipUserViewModel(userClip: UserClip(id: 1,
                                                    name: "Jhon Doe",
                                                    profileUrl: "https://www.pexels.com/@digitech"))
    }
}
