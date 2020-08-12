//
//  NoughtsAndCrossesUITests.swift
//  NoughtsAndCrossesUITests
//
//  Created by Andrew on 22/06/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import XCTest

var app: XCUIApplication!
var gamePage: GamePage!


class NoughtsAndCrossesUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        gamePage = GamePage(app)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBoardRender() {
        XCTAssertTrue(gamePage.isDisplayed())
    }
    
    func testPlayAgain() {
        _ = gamePage.play(moves: [.five])
        gamePage.playAgain()
        XCTAssertTrue(gamePage.isEmpty())
    }
    
    func testNoughtWin() {
        let labels = gamePage.play(moves: [.five, .six, .nine, .seven, .one])
        XCTAssertEqual(labels[TextType.winner.rawValue], "nought wins")
    }
    
    func testCrossWin() {
        let labels = gamePage.play(moves: [.four, .five, .seven, .eight, .nine, .two])
        XCTAssertEqual(labels[TextType.winner.rawValue], "cross wins")
    }
    
    func testMovesForCurrentPlayerText() {
        let firstMoveLabels = gamePage.play(moves: [.two])
        XCTAssertEqual(firstMoveLabels[TextType.current.rawValue], "current player: X")
        
        let secondMoveLabels = gamePage.play(moves: [.seven])
        XCTAssertEqual(secondMoveLabels[TextType.current.rawValue], "current player: O")
    }
    
    

}


