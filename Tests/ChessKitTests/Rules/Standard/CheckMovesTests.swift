//
//  CheckMovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class CheckMovesTests: MovesTests {
    
    func testCheckByQueen() throws {
        self.assert(fen: "8/8/8/3q4/4K3/8/8/8 w - - 0 1",
                    testMoves: "e4d5 e4f4 e4e3")
    }
    
    func testCheckByRook() throws {
        self.assert(fen: "8/8/8/3r4/4K3/8/8/8 w - - 0 1",
                    testMoves: "e4d5 e4f4 e4f3 e4e3")
    }
    
    func testCheckByBishop() throws {
        self.assert(fen: "8/8/8/3b4/4K3/8/8/8 w - - 0 1",
                    testMoves: "e4d5 e4e5 e4f5 e4f4 e4e3 e4d3 e4d4")
    }
    
    func testCheckByKnight() throws {
        self.assert(fen: "8/8/8/3n4/4K3/8/8/8 w - - 0 1",
                    testMoves: "e4d5 e4e5 e4f5 e4f3 e4d3 e4d4")
    }
    
    func testCheckByPawn() throws {
        self.assert(fen: "8/8/3p4/8/3K4/8/8/8 w - - 0 1",
                    testMoves: "d4d5 d4e4 d4e3 d4d3 d4c3 d4c4")
        
        self.assert(fen: "8/3p4/8/8/3K4/8/8/8 w - - 0 1",
                    testMoves: "d4c5 d4d5 d4e5 d4e4 d4e3 d4d3 d4c3 d4c4")
        
        self.assert(fen: "8/3p4/8/4K3/8/8/8/8 w - - 0 1",
                    testMoves: "e5d6 e5f6 e5f5 e5f4 e5e4 e5d4 e5d5")
    }
    
    func testPinnedPieceMoves() throws {
        self.assert(fen: "3kr3/8/8/8/8/8/4Q3/4K3 w - - 0 1",
                    testMoves: "e1d1 e1d2 e1f2 e1f1 e2e3 e2e4 e2e5 e2e6 e2e7 e2e8")
    }
    
    func testKingGoindUnderCheck() throws {
        self.assert(fen: "3kr3/8/8/8/8/8/8/4K3 w - - 0 1",
                    testMoves: "e1d1 e1d2 e1f1 e1f2")
    }
    
    func testKingGoingToCheck() throws {
        self.assert(fen: "3k4/8/8/8/8/5q2/8/6K1 w - - 0 1",
                    testMoves: "g1h2")
    }
    
    func testCoverByPiece() throws {
        self.assert(fen: "2rrr3/8/1k6/8/8/8/7R/3K4 w - - 0 1",
                    testMoves: "h2d2")
    }
    
    func testCastlingUnderCheck() throws {
        self.assert(fen: "3kr3/8/8/8/8/8/8/R3K2R w KQ - 0 1",
                    targets: "d1 d2 f1 f2",
                    at: "e1")
    }

    func testCastlingThroughCheck() throws {
        self.assert(fen: "3rkr2/8/8/8/8/8/8/R3K2R w KQ - 0 1",
                    targets: "e2",
                    at: "e1")
    }
    
    func testCastlingBehindOppositeKing() throws {
        self.assert(fen: "8/8/8/8/8/8/2k5/R3K3 w Q - 0 1",
                    targets: "e2 f2 f1",
                    at: "e1")
    }
    
}
