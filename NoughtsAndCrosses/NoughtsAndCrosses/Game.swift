//
//  Game.swift
//  NoughtsAndCrosses
//
//  Created by Andrew on 22/06/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import Foundation
import UIKit

class Game {
    var board = Board()
    var turn = 1
    var sender: AnyObject
    var end = false
    
    init() {
        self.board = Board()
        self.turn = 1
        self.sender = UIButton()
    }
    

    func makeMove(coord: (Int, Int)) {
        
        let piece: Piece = turn % 2 == 0 ? Piece("X") : Piece("O")

        if self.board.rows[coord.0][coord.1].value == Piece.Value.SPACE {
            self.board.rows[coord.0][coord.1] = piece
            sender.setImage(UIImage(named: "\(piece.value == Piece.Value.NOUGHT ? "Nought" : "Cross").png"), for: UIControl.State())
            turn += 1
        }

    }
    
}

class Board: Equatable {
    static func == (lhs: Board, rhs: Board) -> Bool {
        
        if lhs.rows.count != rhs.rows.count {
            return false
        }
        
        for i in 0..<lhs.rows.count {
            for j in 0...i {
                if lhs.rows[i][j].value != rhs.rows[i][j].value {
                    return false
                }
            }
        }
        
        return true
    }
    
    var rows = [[Piece]]()
    var columns: [[Piece]] {
        var output = Array(repeating: [Piece](), count: rows[0].count)
        
        if rows.allSatisfy({$0.count == rows[0].count}) && !rows.isEmpty {
            
            for row in rows {
                for i in 0..<row.count {
                    output[i].append(row[i])
                }
            }
            
            return output
        }
        else {
            return []
        }
    }
    
    //Classic game
    convenience init() {
        self.init(rows: [[Piece(), Piece(), Piece()], [Piece(), Piece(), Piece()], [Piece(), Piece(), Piece()]])
    }
    
    init(rows: [[Piece]]) {
        self.rows = rows
    }
    
    func win() -> Piece.Value {
        return win(self.rows) ?? win(self.columns) ?? win(rows: self.rows, columns: self.columns) ?? Piece.Value.SPACE
    }
    
    private func win(_ array: [[Piece]]) -> Piece.Value? {
        for element in array {
            for value in Piece.Value.allCases {
                if element.allSatisfy({$0.value == value}) {
                    return value
                }
            }
            
        }
        
        return nil
    }
    
    private func win(rows: [[Piece]], columns: [[Piece]]) -> Piece.Value? {
        
        var leftToRight = [Piece]()
        var rightToLeft = [Piece]()
        
        for i in 0..<rows.count {
            leftToRight.append(rows[i][i])
        }
        
        let reversedColumns: [[Piece]] = columns.reversed()
        for j in 0..<reversedColumns.count{
            rightToLeft.append(reversedColumns[j][j])
        }
        
        if leftToRight.allSatisfy({$0.value == leftToRight[0].value}) {
            return leftToRight[0].value
        }
        else if rightToLeft.allSatisfy({$0.value == rightToLeft[0].value}) {
            return rightToLeft[0].value
        }
        else {
            return nil
        }
    }
    
    func isFull() -> Bool {
        for row in self.rows {
            if row.allSatisfy({$0.value != Piece.Value.SPACE}) {
                continue
            }
            else {
                return false
            }
        }
        return true
    }
    
    func displayInConsole() {
        var output: String = ""
        for row in self.rows {
            for element in row {
                output.append(
                    element.value == Piece.Value.NOUGHT ? "O"
                        : element.value == Piece.Value.CROSS ? "X"
                        : element.value == Piece.Value.SPACE ? "-" : "")
                output.append("   |   ")
            }
            output.append("\n____________________\n")
        }
        print(output)
    }
    
}

class Piece {
    var value: Value = Value.SPACE
    
    init() {
        self.value = Value.SPACE
    }
    
    init(_ value: String) {
        switch value {
        case "O": self.value = Value.NOUGHT
        case "X": self.value = Value.CROSS
        default: self.value = Value.SPACE
        }
    }
    
    enum Value: CaseIterable, Equatable {
        case NOUGHT
        case CROSS
        case SPACE
    }
}
