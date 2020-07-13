//
//  RookMovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class RookMovesTests: MovesTests {
    
    func testAloneInCenter() throws {
        self.assert(
            fen: "8/8/8/3R4/8/8/8/8 w - - 0 1",
            targets: "a5 b5 c5 e5 f5 g5 h5 d1 d2 d3 d4 d6 d7 d8",
            at: "d5"
        )
    }
    
    func testAloneInTopRightCorner() throws {
        self.assert(
            fen: "7R/8/8/8/8/8/8/8 w - - 0 1",
            targets: "a8 b8 c8 d8 e8 f8 g8 h1 h2 h3 h4 h5 h6 h7",
            at: "h8"
        )
    }
    
    func testWithSameColorPieces() throws {
        self.assert(
            fen: "8/3P4/8/3RP3/8/8/3N4/8 w - - 0 1",
            targets: "a5 b5 c5 d3 d4 d6",
            at: "d5"
        )
    }
    
    func testPieceTaking() throws {
        self.assert(
            fen: "8/3p4/8/3Rp3/8/8/3n4/8 w - - 0 1",
            targets: "a5 b5 c5 e5 d2 d3 d4 d6 d7",
            at: "d5"
        )
    }

}
