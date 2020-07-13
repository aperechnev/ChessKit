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
        self.assert(fen: "8/8/8/3r4/4K3/8/8/8 w - - 0 1", targets: "e3 f3 f4 d5", at: "e4")
    }
    
    func testBehindOppositeKing() throws {
        self.assert(fen: "8/8/3k4/8/4K3/8/8/8 w - - 0 1", targets: "f5 f4 f3 e3 d3 d4", at: "e4")
        self.assert(fen: "8/8/3k4/8/3K4/8/8/8 w - - 0 1", targets: "c4 c3 d3 e3 e4", at: "d4")
        self.assert(fen: "8/8/3k4/8/5K2/8/8/8 w - - 0 1", targets: "f5 g5 g4 g3 f3 e3 e4", at: "f4")
    }
    
    func testKingsideCastling() throws {
        self.assert(fen: "r1bqkbnr/pppp1ppp/2n5/8/3pP3/5N2/PPP2PPP/RNBQKB1R w KQkq - 0 4",
                    targets: "d2 e2",
                    at: "e1")
        
        self.assert(fen: "r1bqk1nr/pppp1ppp/2n5/2b5/2BpP3/5N2/PPP2PPP/RNBQK2R w KQkq - 2 5",
                    targets: "d2 e2 f1 g1",
                    at: "e1")
        
        self.assert(fen: "r1b1k2r/ppppqppp/2n2n2/2b5/2BpP3/5N2/PPP2PPP/RNBQK2R w kq - 6 7",
                    targets: "d2 e2 f1",
                    at: "e1")
        
        self.assert(fen: "r1b1k2r/ppppqppp/2n2n2/2b5/2BpP3/2N2N2/PPP2PPP/R1BQK2R b kq - 7 7",
                    targets: "d8 f8 g8",
                    at: "e8")
    }
    
    func testQueensideCastling() throws {
        self.assert(fen: "r1b1kbnr/ppp1qppp/2np4/4p3/3PP3/2N5/PPP1QPPP/R1B1KBNR w KQkq - 4 5",
                    targets: "d1 d2",
                    at: "e1")
        
        self.assert(fen: "r3kbnr/ppp1qppp/2npb3/4p3/3PP3/2N1B3/PPP1QPPP/R3KBNR w KQkq - 6 6",
                    targets: "d1 d2 c1",
                    at: "e1")
        
        self.assert(fen: "r3kbnr/ppp1qppp/2npb3/4p3/3PP3/2N1B3/PPP1QPPP/R2K1BNR b kq - 7 6",
                    targets: "d7 d8 c8",
                    at: "e8")
        
        self.assert(fen: "r2k1bnr/ppp1qppp/2npb3/4p3/3PP3/2N1B3/PPP1QPPP/R2K1BNR w - - 8 7",
                    targets: "c1 d2 e1",
                    at: "d1")
    }

}
