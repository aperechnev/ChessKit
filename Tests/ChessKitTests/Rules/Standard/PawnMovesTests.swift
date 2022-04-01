//
//  PawnMovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class PawnMovesTests: XCTestCase {
    
    func testAlone() throws {
        self.assert(fen: "8/8/8/8/8/8/4P3/8 w - - 0 1", moves: "e2e3 e2e4", coordinate: "e2")
        self.assert(fen: "8/5p2/8/8/8/8/8/8 b - - 0 1", moves: "f7f6 f7f5", coordinate: "f7")
        self.assert(fen: "8/8/8/4P3/8/8/8/8 w - - 0 1", moves: "e5e6", coordinate: "e5")
        self.assert(fen: "8/8/8/2p5/8/8/8/8 b - - 0 1", moves: "c5c4", coordinate: "c5")
        
        self.assert(fen: "8/8/8/8/8/5N2/5P2/8 w - - 0 1", moves: "", coordinate: "f2")
        self.assert(fen: "8/2p5/2q5/8/8/8/8/8 b - - 0 1", moves: "", coordinate: "c7")
    }
    
    func testPieceTaking() throws {
        self.assert(fen: "8/8/8/8/3n4/5n2/4P3/8 w - - 0 1", moves: "e2e3 e2e4 e2f3", coordinate: "e2")
        self.assert(fen: "8/8/5n2/4P3/8/8/8/8 w - - 0 1", moves: "e5e6 e5f6", coordinate: "e5")
        self.assert(fen: "8/p7/1N6/8/8/8/8/8 b - - 0 1", moves: "a7a6 a7a5 a7b6", coordinate: "a7")
        self.assert(fen: "8/8/8/8/8/3p4/4N3/8 b - - 0 1", moves: "d3d2 d3e2", coordinate: "d3")
    }
    
    func testPromotion() throws {
        self.assert(fen: "3n4/4P3/8/8/8/8/8/8 w - - 0 1",
                    moves: "e7d8Q e7d8R e7d8B e7d8N e7e8Q e7e8R e7e8B e7e8N",
                    coordinate: "e7")
        
        self.assert(fen: "3nr3/4P3/8/8/8/8/8/8 w - - 0 1",
                    moves: "e7d8Q e7d8R e7d8B e7d8N",
                    coordinate: "e7")
        
        self.assert(fen: "8/8/8/8/8/8/2p5/3B4 b - - 0 1",
                    moves: "c2c1q c2c1r c2c1b c2c1n c2d1q c2d1r c2d1b c2d1n",
                    coordinate: "c2")
        
        self.assert(fen: "8/8/8/8/8/8/2p5/2RB4 b - - 0 1",
                    moves: "c2d1q c2d1r c2d1b c2d1n",
                    coordinate: "c2")
    }
    
    func testEnPassant() throws {
        self.assert(fen: "rnbqkbnr/pp2pppp/2p5/3pP3/8/8/PPPP1PPP/RNBQKBNR w KQkq d6 0 3",
                    moves: "e5e6 e5d6",
                    coordinate: "e5")
        
        self.assert(fen: "rnbqkbnr/ppp1pppp/8/8/3pP1P1/7P/PPPP1P2/RNBQKBNR b KQkq e3 0 3",
                    moves: "d4d3 d4e3",
                    coordinate: "d4")
        
        self.assert(fen: "8/8/3p2k1/P2Pr1Pp/3R2KP/8/8/8 w - h6 0 2",
                moves: "g5h6",
                coordinate: "g5")
    }
    
    private func assert(fen: String, moves: String, coordinate: String) {
        let position = FenSerialization.default.deserialize(fen: fen)
        let square = Square(coordinate: coordinate)
        let moves = moves.split(separator: " ").map { "\($0)" }
        let testMoves = StandardRules().movesForPiece(at: square, in: position)
        
        XCTAssertEqual(
            moves.map({ $0.lowercased() }).sorted(),
            testMoves.map({ $0.description.lowercased() }).sorted(),
            "Position: \(fen)"
        )
    }

}
