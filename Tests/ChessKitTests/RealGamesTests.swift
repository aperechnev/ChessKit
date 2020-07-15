//
//  RealGamesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 14.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class RealGamesTests: XCTestCase {
    
    func testGame1() throws {
        let moves = "g1h3 c7c6 h3g5 e7e5 g5e4 d7d5 d2d4".split(separator: " ").map { $0.description }
        
        let initialFen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
        let position = FenSerialization.default.deserialize(fen: initialFen)
        let game = Game(position: position)
        
        moves.forEach { game.make(move: $0) }
        
        let finalFen = FenSerialization.default.serialize(position: game.position)
        XCTAssertEqual(
            finalFen.split(separator: " ").first,
            "rnbqkbnr/pp3ppp/2p5/3pp3/3PN3/8/PPP1PPPP/RNBQKB1R b KQkq - 0 4".split(separator: " ").first
        )
    }
    
    func testGame2() throws {
        let fen = "8/1p3p1k/4p3/3p4/6p1/1K6/8/2q5 w - - 0 52"
        let position = FenSerialization.default.deserialize(fen: fen)
        let game = Game(position: position)
        let legalMoves = game.legalMoves.map { $0.description }
        
        XCTAssertFalse(legalMoves.contains("b3b2"))
    }

}
