//
//  StandardRulesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class StandardRulesTests: MovesTests {
    
    func testScotchGameLegalMoves() throws {
        self.assert(
            fen: "r1bqkbnr/pppp1ppp/2n5/8/3pP3/5N2/PPP2PPP/RNBQKB1R w KQkq - 0 4",
            testMoves: "a2a3 a2a4 b2b3 b2b4 c2c3 c2c4 e4e5 g2g3 g2g4 h2h3 h2h4 b1a3 b1c3 b1d2 c1d2 c1e3 c1f4 c1g5 c1h6 d1d2 d1d3 d1d4 d1e2 e1d2 e1e2 f1e2 f1d3 f1c4 f1b5 f1a6 f3d2 f3d4 f3e5 f3g5 f3h4 f3g1 h1g1"
        )
    }
    
    func testCaroKannLegalMoves() throws {
        self.assert(
            fen: "rnbqkbnr/pp2pppp/2p5/3pP3/3P4/8/PPP2PPP/RNBQKBNR b KQkq - 0 3",
            testMoves: "h7h6 h7h5 g7g6 g7g5 f7f6 f7f5 e7e6 c6c5 b7b6 b7b5 a7a6 a7a5 g8h6 g8f6 e8d7 d8d7 d8d6 d8c7 d8b6 d8a5 c8d7 c8e6 c8f5 c8g4 c8h3 b8d7 b8a6"
        )
    }

}
