//
//  QuickClipsUITests.swift
//  QuickClipsUITests
//
//  Created by Santiago Moreno on 29/06/24.
//

import XCTest

final class ClipsFeedViewUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()
    }
    
    func testFeedAndNavigation() throws {
        let app = XCUIApplication()
        
        let feedView = app.otherElements["FeedView"]
        XCTAssertTrue(feedView.exists, "The FeedView should exists")
        
        let cardButton = app.buttons["ClipCardViewButton0"]
        XCTAssertTrue(cardButton.exists, "The ClipCardViewButton0 should exists")
        cardButton.tap()
        
        let detailView = app.otherElements["ClipDetailView"]
        XCTAssertTrue(detailView.exists, "The ClipDetailView should exists")
    }
}
