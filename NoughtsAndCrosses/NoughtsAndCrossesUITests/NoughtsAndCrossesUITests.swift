//
//  NoughtsAndCrossesUITests.swift
//  NoughtsAndCrossesUITests
//
//  Created by Andrew on 22/06/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDiplayingBoard: Bool {
        return otherElements["main-board-view"].exists
    }
    
    var getWinnerText: String {
        return otherElements["winner-text"].value(forKey: "winner-text")
    }
    
    var isDisplayingCurrentPlayerText: Bool {
        return otherElements["current-player-text"].exists
    }
}

class NoughtsAndCrossesUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBoardRender() {
        XCTAssertTrue(app.isDiplayingBoard)
        XCTAssertFalse(app.getWinnerText == "")
        XCTAssertTrue(app.isDisplayingCurrentPlayerText)
    }
    
    func testPlayAgain() {
        let centreButton = app.buttons["Button11"]
        centreButton.tap()
        
        app.buttons["play again"].tap()
        
        XCTAssert(app.buttons["play again"].images == nil)
        
    }
    
    func testNoughtWin() {
        app.buttons["Button11"].tap()
        app.buttons["Button12"].tap()
        app.buttons["Button22"].tap()
        app.buttons["Button20"].tap()
        app.buttons["Button00"].tap()
        XCTAssert(app.getWinnerText == "nought wins")
    }
    
    func testCrossWin() {
        
    }
    
    func testDraw() {
        
    }
    
    func testPlaceNought() {
        
    }
    
    func testPlaceCross() {
        
    }

}


