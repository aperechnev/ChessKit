//
//  KingMovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class KingMovesTests: MovesTests {
    
    func testAloneInCenter() throws {
        self.assert(fen: "8/8/8/8/4K3/8/8/8 w - - 0 1", targets: "d5 e5 f5 d4 f4 d3 e3 f3", at: "e4")
    }
    
    func testAloneInTopLeftCorner() throws {
        self.assert(fen: "K7/8/8/8/8/8/8/8 w - - 0 1", targets: "a7 b7 b8", at: "a8")
    }
    
    func testAloneInTopRightCorner() throws {
        self.assert(fen: "7K/8/8/8/8/8/8/8 w - - 0 1", targets: "g8 g7 h7", at: "h8")
    }
    
    func testAloneInBottomRightCorner() throws {
        self.assert(fen: "8/8/8/8/8/8/8/7K w - - 0 1", targets: "g1 g2 h2", at: "h1")
    }
    
    func testAloneInBottomLeftCorner() throws {
        self.assert(fen: "8/8/8/8/8/8/8/K7 w - - 0 1", targets: "a2 b2 b1", at: "a1")
    }
    
    func testStuckWithSameColorPieces() throws {
        self.assert(fen: "8/8/8/3PPP2/3PKP2/3PPP2/8/8 w - - 0 1", targets: "", at: "e4")
    }
    
    func testWithSameColorPieces() throws {
        self.assert(fen: "8/8/8/3PP3/3PK3/3P1P2/8/8 w - - 0 1", targets: "f5 f4 e3", at: "e4")
    }
    
    func testTakingPieces() throws {
        self.assert(fen: "8/8/8/3PPp2/3pKP2/3PpP2/8/8 w - - 0 1", targets: "f5 d4 e3", at: "e4")
    }
    
    func testTakingProtectedPieces() throws {
        XCTFail("Not implemented.")
    }
    
    func testGoingUnderCheck() throws {
        XCTFail("Not implemented.")
    }
    
    func testBehindOppositeKing() throws {
        self.assert(fen: "8/8/3k4/8/4K3/8/8/8 w - - 0 1", targets: "f5 f4 f3 e3 d3 d4", at: "e4")
    }
    
    func testCastling() throws {
        XCTFail("Not implemented.")
    }

}
