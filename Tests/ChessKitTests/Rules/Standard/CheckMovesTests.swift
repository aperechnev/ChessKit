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
    
}
