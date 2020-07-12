//
//  BishopMovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class BishopMovesTests: MovesTests {
    
    func testAloneInCenter() throws {
        self.assert(
            fen: "8/8/8/4b3/8/8/8/8 b - - 0 1",
            targets: " a1 b2 c3 d4 f6 g7 h8 b8 c7 d6 f4 g3 h2",
            at: "e5"
        )
    }
    
    func testAloneInTopRightCorner() throws {
        self.assert(
            fen: "7b/8/8/8/8/8/8/8 b - - 0 1",
            targets: "a1 b2 c3 d4 e5 f6 g7",
            at: "h8"
        )
    }
    
    func testWithSameColorPieces() throws {
        self.assert(
            fen: "8/1k6/8/3b4/2r5/8/8/7p b - - 0 1",
            targets: "e6 f7 g8 c6 e4 f3 g2",
            at: "d5"
        )
    }
    
    func testPieceTaking() throws {
        self.assert(
            fen: "8/1Q6/8/3b4/2R5/8/6P1/8 b - - 0 1",
            targets: "c4 e6 f7 g8 b7 c6 e4 f3 g2",
            at: "d5"
        )
    }

}
