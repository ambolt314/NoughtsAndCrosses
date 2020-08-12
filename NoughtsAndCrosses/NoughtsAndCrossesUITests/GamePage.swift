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
        print("BUTTONS: \(Button.allCases)")
        
        for buttonIdentifier in Button.allCases {
            let image: UIImage? = ((self.app.buttons[buttonIdentifier.rawValue] as XCUIElementQuery) as UIButton).imageView?.image
            
        }
        return Button.allCases.allSatisfy(
            { (self.app.buttons[$0.rawValue] as UIButton)
                .imageView?
                .image != Piece.x.rawValue
                ||
                (app.buttons[$0.rawValue] as UIButton)
                    .imageView?
                    .image != Piece.x.rawValue
        })
    }
    
    func playAgain() {
        app.buttons["play again"].tap()
    }
    
    ///Indicates whether the current page equals the given board
    func equals(board: [Piece]) -> Bool {
        var currentBoard: [Piece] = Array()
        
        for button in Button.allCases {
            switch app.buttons[button.rawValue].label {
            case "X": currentBoard.append(.x)
            case "O": currentBoard.append(.o)
            default: continue
            }
        }
        
        for (current, expected) in zip(currentBoard, board) {
            if current != expected {
                return false
            }
        }
        
        return true
    }
}




///The nomenclature of the buttons with respect to the game grid
/*
 1   |   2   |   3
 __________________
 4   |   5   |   6
 __________________
 7   |   8   |   9
*/

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

enum Piece: String {
    case x = "image-url-for-cross"
    case o = "image-url-for-nought"
}

extension XCUIApplication {
    
    var winnerText: String? {
        return app.staticTexts["winner-text"].exists ? app.staticTexts["winner-text"].label : nil
    }
    
    var currentPlayerText: String? {
        return app.staticTexts["current-player-text"].exists ? app.staticTexts["current-player-text"].label : nil
    }
}
