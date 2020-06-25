//
//  NoughtsAndCrossesUITests.swift
//  NoughtsAndCrossesUITests
//
//  Created by Andrew on 22/06/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import XCTest

var app: XCUIApplication!

extension XCUIApplication {
    var isDiplayingBoard: Bool {
        return otherElements["main-board-view"].exists
    }
    
    var getWinnerText: String {
        return app.staticTexts["winner-text"].label
    }
    
    var getCurrentPlayerText: String {
        return app.staticTexts["current-player-text"].label
    }
}

class NoughtsAndCrossesUITests: XCTestCase {

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
        XCTAssert(app.getCurrentPlayerText == "Current player: O")
    }
    
    func testPlayAgain() {
        let centreButton = app.buttons["Button11"]
        centreButton.tap()
        
        app.buttons["play again"].tap()
        
        //check that board is now empty
    }
    
    func testNoughtWin() {
        app.buttons["Button11"].tap() //O
        app.buttons["Button12"].tap() //X
        app.buttons["Button22"].tap() //O
        app.buttons["Button20"].tap() //X
        app.buttons["Button00"].tap() //O
        XCTAssert(app.getWinnerText == "nought wins")
    }
    
    func testCrossWin() {
        app.buttons["Button10"].tap() //O
        app.buttons["Button11"].tap() //X
        app.buttons["Button20"].tap() //O
        app.buttons["Button21"].tap() //X
        app.buttons["Button22"].tap() //O
        app.buttons["Button01"].tap() //X
        XCTAssert(app.getWinnerText == "cross wins")
    }
    
    func testMovesForCurrentPlayerText() {
        app.buttons["Button01"].tap() //O
        XCTAssert(app.getCurrentPlayerText == "Current player: X")
        
        app.buttons["Button20"].tap() //X
        XCTAssert(app.getCurrentPlayerText == "Current player: O")
    }
    
    

}


