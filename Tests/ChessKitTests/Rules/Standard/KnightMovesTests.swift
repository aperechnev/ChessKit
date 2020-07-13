//
//  KnightMovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class KnightMovesTests: MovesTests {
    
    func testAloneInCenter() throws {
        self.assert(
            fen: "8/8/8/4N3/8/8/8/8 w - - 0 1",
            targets: "c6 d7 f7 g6 g4 f3 d3 c4",
            at: "e5"
        )
    }
    
    func testAloneInTopRightCorner() throws {
        self.assert(
            fen: "7N/8/8/8/8/8/8/8 w - - 0 1",
            targets: "f7 g6",
            at: "h8"
        )
    }
    
    func testWithSameColorPieces() throws {
        self.assert(
            fen: "8/5P2/2K5/4N3/8/3R4/8/8 w - - 0 1",
            targets: "d7 g6 g4 f3 c4",
            at: "e5"
        )
    }
    
    func testPieceTaking() throws {
        self.assert(
            fen: "8/5p2/2k5/4N3/8/3r4/8/8 w - - 0 1",
            targets: "c6 d7 f7 g6 g4 f3 d3 c4",
            at: "e5"
        )
    }

}
