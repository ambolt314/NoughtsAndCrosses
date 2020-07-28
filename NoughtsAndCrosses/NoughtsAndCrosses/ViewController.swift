//
//  ViewController.swift
//  NoughtsAndCrosses
//
//  Created by Andrew on 22/06/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game = Game()
    
    @IBOutlet weak var winText: UILabel!
    @IBOutlet weak var currentPlayerText: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBAction func playAgain(_ sender: UIButton) {

        winText.isHidden = true
        game = Game()
        
        for i in 1...9 {
            
            let subview = view.viewWithTag(i)
            
            if subview is UIButton {
                let button = subview as! UIButton
                button.setImage(nil, for: UIControl.State())
            }
        }

        game.board.displayInConsole()
    }
    
    @IBAction func pressButton(_ sender: AnyObject) {
        game.sender = sender
        
        if !game.end {
            
            let coords = (game.sender.tag - 1).quotientAndRemainder(dividingBy: game.board.rows.count)
            game.makeMove(coord: coords)
            game.board.displayInConsole()
            currentPlayerText.text = "\(NSLocalizedString("Current player", comment: "")): \(game.turn % 2 == 0 ? "X" : "O")"
            currentPlayerText.isHidden = false
            game.end = game.board.win() != Piece.Value.SPACE
        
        
        switch(game.board.win()) {
        case Piece.Value.NOUGHT:
            winText.text = "\(NSLocalizedString("nought", comment: "")) \(NSLocalizedString("wins", comment: ""))"
            winText.isHidden = false
        case Piece.Value.CROSS:
            winText.text = "\(NSLocalizedString("cross", comment: "")) \(NSLocalizedString("wins", comment: ""))"
            winText.isHidden = false
        case Piece.Value.SPACE:
            winText.isHidden = true
        }
    }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "main-board-view"
        winText.accessibilityIdentifier = "winner-text"
        print("Play again text: \(String(describing: playAgainButton.titleLabel?.text))\nLocalised version: \( NSLocalizedString("play again", comment: ""))")
        playAgainButton.titleLabel?.text = "Andrew"//"\( NSLocalizedString("play again", comment: "") )"
        currentPlayerText.accessibilityIdentifier = "current-player-text"
        currentPlayerText.text = "\(NSLocalizedString("Current player", comment: "")): O"
    }

}



