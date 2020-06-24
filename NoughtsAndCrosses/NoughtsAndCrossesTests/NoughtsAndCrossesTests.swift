import XCTest
@testable import NoughtsAndCrosses

class NoughtsAndCrossesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testColumnsTransposeOfRows() {
        let board = Board(rows: [[Piece("O"), Piece("O"), Piece("O")], [Piece(), Piece(), Piece()], [Piece(), Piece(), Piece()]])
        let transposed = Board(rows: [[Piece("O"), Piece(), Piece()], [Piece("O"), Piece(), Piece()], [Piece("O"), Piece(), Piece()]])
        
        for i in 0...board.columns.count - 1 {
            for j in 0...board.columns[i].count - 1 {
                if board.columns[i][j].value != transposed.rows[i][j].value {
                    XCTFail()
                }
            }
        }
        XCTAssertTrue(true, "Test passed")
        
    }
    
    func testNoughtsRowWin() {
        let board = Board(rows: [[Piece("O"), Piece("O"), Piece("O")], [Piece(), Piece(), Piece()], [Piece(), Piece(), Piece()]])
        XCTAssert(board.win() == Piece.Value.NOUGHT)
        
    }
    
    func testCrossesRowWin() {
        let board = Board(rows: [[Piece("X"), Piece("X"), Piece("X")], [Piece(), Piece(), Piece()], [Piece(), Piece(), Piece()]])
        XCTAssert(board.win() == Piece.Value.CROSS)
    }
    
    func testNoughtsColumnWin() {
        let board = Board(rows: [[Piece("O"), Piece(), Piece()], [Piece("O"), Piece(), Piece()], [Piece("O"), Piece(), Piece()]])
        XCTAssert(board.win() == Piece.Value.NOUGHT)
    }
    
    func testCrossesColumnWin() {
        let board = Board(rows: [[Piece("X"), Piece(), Piece()], [Piece("X"), Piece(), Piece()], [Piece("X"), Piece(), Piece()]])
        XCTAssert(board.win() == Piece.Value.CROSS)
    }
    
    func testNoughtsDiagonalWin1() {
        let board = Board(rows: [[Piece("O"), Piece(), Piece()], [Piece(), Piece("O"), Piece()], [Piece(), Piece(), Piece("O")]])
        XCTAssert(board.win() == Piece.Value.NOUGHT)
    }
    
    func testNoughtsDiagonalWin2() {
        let board = Board(rows: [[Piece(), Piece(), Piece("O")], [Piece(), Piece("O"), Piece()], [Piece("O"), Piece(), Piece()]])
        print("Winning piece: \(board.win())")
        print("Expected winner: \(Piece.Value.NOUGHT)")
        XCTAssert(board.win() == Piece.Value.NOUGHT)
    }
    
    func testCrossesDiagonalWin1() {
        let board = Board(rows: [[Piece("X"), Piece(), Piece()], [Piece(), Piece("X"), Piece()], [Piece(), Piece(), Piece("X")]])
        XCTAssert(board.win() == Piece.Value.CROSS)
    }
    func testCrossesDiagonalWin2() {
        let board = Board(rows: [[Piece(), Piece(), Piece("X")], [Piece(), Piece("X"), Piece()], [Piece("X"), Piece(), Piece()]])
        print("Winning piece: \(board.win())")
        print("Expected winner: \(Piece.Value.CROSS)")
        XCTAssert(board.win() == Piece.Value.CROSS)
    }
    
    func testNoWinner() {
        let board = Board(rows: [[Piece("O"), Piece("O"), Piece("X")], [Piece("O"), Piece("X"), Piece("X")], [Piece(), Piece("O"), Piece("O")]])
        XCTAssert(board.win() == Piece.Value.SPACE)
    }
    
    func testCrossWin() {
        let board = Board(rows: [[Piece("O"), Piece("O"), Piece("X")], [Piece("O"), Piece("X"), Piece("X")], [Piece("X"), Piece("O"), Piece("O")]])
        XCTAssert(board.win() == Piece.Value.CROSS)
    }
    
    func testNoughtWin() {
        let board = Board(rows: [[Piece("O"), Piece("O"), Piece("X")], [Piece("O"), Piece("X"), Piece("X")], [Piece("O"), Piece("O"), Piece("O")]])
        XCTAssert(board.win() == Piece.Value.NOUGHT)
    }
    
    func testBoardIsFullTrue() {
        let board = Board(rows: [[Piece("O"), Piece("O"), Piece("X")], [Piece("O"), Piece("X"), Piece("X")], [Piece("O"), Piece("O"), Piece("O")]])
        XCTAssert(board.isFull() == true)
    }
    
    func testBoardIsFullFalse() {
        let board = Board(rows: [[Piece(), Piece(), Piece()], [Piece("O"), Piece("X"), Piece()], [Piece(), Piece(), Piece("O")]])
        XCTAssert(board.isFull() == false)
    }

}
