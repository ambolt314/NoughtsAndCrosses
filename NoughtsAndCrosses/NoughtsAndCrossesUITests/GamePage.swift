//
//  GamePage.swift
//  NoughtsAndCrossesUITests
//
//  Created by Andrew Bolt on 12/08/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
import XCTest

///Models the game page to a class
class GamePage {
    
    var app: XCUIApplication!
    
    init(_ app: XCUIApplication) {
        self.app = app
    }
    
    ///@return the current player and winner text
    func play(moves: [Button]) -> [String?] {
        
        for move in moves {
            self.app.buttons[move.rawValue].tap()
        }
        
        return [self.app.currentPlayerText, self.app.winnerText]
    }
    
    func isDisplayed() -> Bool {
        return app.otherElements["main-board-view"].exists
    }
    
    func isEmpty() -> Bool {
        Button.allCases.allSatisfy({app.buttons[$0.rawValue].label == ""})
    }
    
    func playAgain() {
        app.buttons["play again"].tap()
    }
}

enum Button: String, CaseIterable {
    case one = "Button00"
    case two = "Button01"
    case three = "Button02"
    case four = "Button10"
    case five = "Button11"
    case six = "Button12"
    case seven = "Button20"
    case eight = "Button21"
    case nine = "Button22"
}

enum TextType: Int {
    case current = 0
    case winner = 1
}

extension XCUIApplication {
    
    var winnerText: String? {
        return app.staticTexts["winner-text"].label
    }
    
    var currentPlayerText: String? {
        return app.staticTexts["current-player-text"].label
    }
}
