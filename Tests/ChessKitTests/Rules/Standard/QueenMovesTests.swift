//
//  QueenMovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class QueenMovesTests: MovesTests {
    
    func testAloneInCenter() throws {
        self.assert(
            fen: "8/8/8/4q3/8/8/8/8 b - - 0 1",
            targets: "e1 e2 e3 e4 e6 e7 e8 a5 b5 c5 d5 f5 g5 h5 a1 b2 c3 d4 f6 g7 h8 b8 c7 d6 f4 g3 h2",
            at: "e5"
        )
    }
    
    func testAloneInTopRightCorner() throws {
        self.assert(
            fen: "7q/8/8/8/8/8/8/8 b - - 0 1",
            targets: "a8 b8 c8 d8 e8 f8 g8 a1 b2 c3 d4 e5 f6 g7 h1 h2 h3 h4 h5 h6 h7",
            at: "h8"
        )
    }
    
    func testWithSameColorPieces() throws {
        self.assert(
            fen: "8/4n3/5q2/8/3p4/8/5p2/8 b - - 0 1",
            targets: "a6 b6 c6 d6 e6 g6 h6 f3 f4 f5 f7 f8 e5 g7 h8 g5 h4",
            at: "f6"
        )
    }
    
    func testPieceTaking() throws {
        self.assert(
            fen: "8/4N3/5q2/8/3P4/8/5P2/8 b - - 0 1",
            targets: "a6 b6 c6 d6 e6 g6 h6 f2 f3 f4 f5 f7 f8 d4 e5 g7 h8 e7 g5 h4",
            at: "f6"
        )
    }

}
