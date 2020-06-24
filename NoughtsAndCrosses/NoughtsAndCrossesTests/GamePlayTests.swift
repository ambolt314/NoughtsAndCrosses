import XCTest
@testable import NoughtsAndCrosses

class GamePlayTests: XCTestCase {
    
    func testFirstMove() {
        let game = Game()
        
        game.makeMove(coord: (1, 2))
        
        let expected = Board(rows: [[Piece(), Piece("O"), Piece()], [Piece(), Piece(), Piece()], [Piece(), Piece(), Piece()]] )
        
        game.board.displayInConsole()
        
        XCTAssert(game.board == expected)
        
    }
    
    func testGameStartup() {
        let game = Game()
        XCTAssert(game.turn == 1)
        XCTAssert(game.board == Board())
    }
    
    func testNextMove() {
        let game = Game()
        
        game.makeMove(coord: (0, 1))
        game.makeMove(coord: (0, 2))
        
        let expected = Board(rows: [[Piece(), Piece("O"), Piece("X")], [Piece(), Piece(), Piece()], [Piece(), Piece(), Piece()]] )
        
        XCTAssert(game.board == expected)
        
    }
    
    func testOverrideAttempt() {
        let game = Game()
        
        game.makeMove(coord: (2,2))
        game.makeMove(coord: (2, 2))
        
        let expected = Board(rows: [[Piece(), Piece(), Piece()], [Piece(), Piece(), Piece()], [Piece(), Piece(), Piece("O")]])
        
        XCTAssert(game.board == expected)
        
        
    }
    
    func testNoughtWinningMove() {
        let game = Game()
        
        game.makeMove(coord: (0, 0)) //O
        game.makeMove(coord: (1, 1)) //X
        game.makeMove(coord: (0, 1)) //O
        game.makeMove(coord: (0, 2)) //X
        game.makeMove(coord: (1, 0)) //O
        game.makeMove(coord: (1, 2)) //X
        game.makeMove(coord: (2, 2)) //O
        game.makeMove(coord: (2, 1)) //X
        game.makeMove(coord: (2,0)) //O
        let expected = Board(rows: [[Piece("O"), Piece("O"), Piece("X")], [Piece("O"), Piece("X"), Piece("X")], [Piece("O"), Piece("X"), Piece("O")]])
        game.board.displayInConsole()
        expected.displayInConsole()
        XCTAssert(game.board == expected)
        XCTAssert(game.board.win() == Piece.Value.NOUGHT)
    }
    
    func testCrossWinningMove() {
        let game = Game()
        
        game.makeMove(coord: (0, 1)) //O
        game.makeMove(coord: (1, 1)) //X
        game.makeMove(coord: (1, 0)) //O
        game.makeMove(coord: (0, 2)) //X
        game.makeMove(coord: (2,0)) //O
        game.makeMove(coord: (0, 0)) //X
        game.makeMove(coord: (1,2)) //O
        game.makeMove(coord: (2, 2)) //X
        game.makeMove(coord: (2, 1)) //O
        
        let expected = Board(rows: [[Piece("X"), Piece("O"), Piece("X")], [Piece("O"), Piece("X"), Piece("O")], [Piece("O"), Piece("O"), Piece("X")]])
        
        XCTAssert(game.board == expected)
        XCTAssert(game.board.win() == Piece.Value.CROSS)
    }
    
    func testInitialEndGame() {
        let game = Game()
        XCTAssert(game.end == false)
    }
    
    func testEndGameAfterMove() {
        let game = Game()
        let noMoves = game.end
        
        game.makeMove(coord: (1, 1))
        let firstMove = game.end
        
        XCTAssertFalse(noMoves)
        XCTAssertFalse(firstMove)
    }
    
    func testEndGameForWin() {
        
        let game = Game()
        let noMoves = game.end
        
        game.makeMove(coord: (0, 1)) //O
        game.makeMove(coord: (1, 1)) //X
        game.makeMove(coord: (1, 0)) //O
        game.makeMove(coord: (0, 2)) //X
        game.makeMove(coord: (2,0)) //O
        game.makeMove(coord: (0, 0)) //X
        game.makeMove(coord: (1,2)) //O
        game.makeMove(coord: (2, 2)) //X
        game.makeMove(coord: (2, 1)) //O
        
        let afterNineMoves = game.end
        
        XCTAssertFalse(noMoves)
        XCTAssertTrue(afterNineMoves)
        
    }
    
    func testEndGameForDraw() {
        let game = Game()
        let noMoves = game.end
        
        for i in 0...2 {
            for j in 0...2 {
                game.makeMove(coord: (i, j))
            }
        }
        
        let completedMoved = game.end
        
        XCTAssertFalse(noMoves)
        XCTAssert(game.board.win() == Piece.Value.SPACE)
        XCTAssertTrue(completedMoved)
    }
}


