//
//  GameTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class GameTests: XCTestCase {
    
    func testMovesHistory() throws {
        let fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
        let position = FenSerialization.default.deserialize(fen: fen)
        let game = Game(position: position)
        
        let moves = ["e2e4", "e7e5", "g1f3", "b8c6", "d2d4", "e5d4"]
            .map { Move(string: $0) }
        
        moves.forEach { game.make(move: $0) }
        
        XCTAssertEqual(moves, game.movesHistory)
        
        XCTAssertEqual(
            "r1bqkbnr/pppp1ppp/2n5/8/3pP3/5N2/PPP2PPP/RNBQKB1R w KQkq - 0 4",
            FenSerialization.default.serialize(position: game.position)
        )
    }
    
    func testPositionsCounter() throws {
        let fen = "1K2Q3/8/8/6p1/5pk1/8/7P/8 w - - 3 66"
        let position = FenSerialization.default.deserialize(fen: fen)
        let game = Game(position: position)
        
        XCTAssertEqual(game.positionsCounter[game.position.board], 1)
        
        game.make(move: "b8a8")
        game.make(move: "g4f3")
        game.make(move: "a8b8")
        game.make(move: "f3g4")
        XCTAssertEqual(game.positionsCounter[game.position.board], 2)
        
        game.make(move: "b8a8")
        game.make(move: "g4f3")
        game.make(move: "a8b8")
        game.make(move: "f3g4")
        XCTAssertEqual(game.positionsCounter[game.position.board], 3)
    }
    
    func testSimpleMove() throws {
        let initialFen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
        let position = FenSerialization.default.deserialize(fen: initialFen)
        let rules = StandardRules()
        let game = Game(position: position, rules: rules)
        
        game.make(move: "e2e4")
        XCTAssertEqual(game.position.board["e4"], Piece(kind: .pawn, color: .white))
        XCTAssertNil(game.position.board["e2"])
        XCTAssertEqual(game.position.state.turn, PieceColor.black)
        XCTAssertEqual(game.position.state.enPasant, Square(coordinate: "e3"))
        XCTAssertEqual(game.position.counter.fullMoves, 1)
        
        game.make(move: "d7d5")
        XCTAssertEqual(game.position.state.turn, PieceColor.white)
        XCTAssertEqual(game.position.state.enPasant, Square(coordinate: "d6"))
        XCTAssertEqual(game.position.counter.fullMoves, 2)
        
        game.make(move: "g1f3")
        XCTAssertNil(game.position.state.enPasant)
        XCTAssertEqual(game.position.counter.halfMoves, 1)
    }
    
    func testLoosingKingCastling() throws {
        let fen = "r1bqk1nr/pppp1ppp/2n5/2b5/2BpP3/5N2/PPP2PPP/RNBQK2R w KQkq - 2 5"
        let position = FenSerialization.default.deserialize(fen: fen)
        let rules = StandardRules()
        let game = Game(position: position, rules: rules)
        
        XCTAssertTrue(game.position.state.castlings.contains(Piece(kind: .king, color: .white)))
        
        game.make(move: "h1g1")
        XCTAssertFalse(game.position.state.castlings.contains(Piece(kind: .king, color: .white)))
    }
    
    func testLoosingQueenCastling() throws {
        let fen = "4k3/8/8/8/8/8/8/R3K2R w KQ - 0 1"
        let position = FenSerialization.default.deserialize(fen: fen)
        let rules = StandardRules()
        let game = Game(position: position, rules: rules)
        
        XCTAssertTrue(game.position.state.castlings.contains(Piece(kind: .queen, color: .white)))
        
        game.make(move: "a1b1")
        XCTAssertFalse(game.position.state.castlings.contains(Piece(kind: .queen, color: .white)))
    }
    
    func testLoosingAllCastlings() throws {
        let fen = "4k3/8/8/8/8/8/8/R3K2R w KQ - 0 1"
        let position = FenSerialization.default.deserialize(fen: fen)
        let rules = StandardRules()
        let game = Game(position: position, rules: rules)
        
        XCTAssertTrue(game.position.state.castlings.contains(Piece(kind: .queen, color: .white)))
        XCTAssertTrue(game.position.state.castlings.contains(Piece(kind: .king, color: .white)))
        
        game.make(move: "e1e2")
        XCTAssertFalse(game.position.state.castlings.contains(Piece(kind: .queen, color: .white)))
        XCTAssertFalse(game.position.state.castlings.contains(Piece(kind: .king, color: .white)))
    }
    
    func testKingCastling() throws {
        let fen = "4k3/8/8/8/8/8/8/R3K2R w KQ - 0 1"
        let position = FenSerialization.default.deserialize(fen: fen)
        let rules = StandardRules()
        let game = Game(position: position, rules: rules)
        
        game.make(move: "e1g1")
        
        XCTAssertNil(game.position.board["e1"])
        XCTAssertEqual(game.position.board["f1"], Piece(kind: .rook, color: .white))
        XCTAssertEqual(game.position.board["g1"], Piece(kind: .king, color: .white))
        XCTAssertNil(game.position.board["h1"])
    }
    
    func testQueenCastling() throws {
        let fen = "4k3/8/8/8/8/8/8/R3K2R w KQ - 0 1"
        let position = FenSerialization.default.deserialize(fen: fen)
        let rules = StandardRules()
        let game = Game(position: position, rules: rules)
        
        game.make(move: "e1c1")
        
        XCTAssertNil(game.position.board["a1"])
        XCTAssertNil(game.position.board["b1"])
        XCTAssertEqual(game.position.board["c1"], Piece(kind: .king, color: .white))
        XCTAssertEqual(game.position.board["d1"], Piece(kind: .rook, color: .white))
        XCTAssertNil(game.position.board["e1"])
    }
    
    func testEnPassantTaking() throws {
        let fen = "rnbqkbnr/p1pppppp/8/6P1/1pP5/8/PP1PPP1P/RNBQKBNR b KQkq c3 0 3"
        let position = FenSerialization.default.deserialize(fen: fen)
        let rules = StandardRules()
        let game = Game(position: position, rules: rules)
        
        game.make(move: "b4c3")
        XCTAssertNil(game.position.board["b4"])
        XCTAssertNil(game.position.board["c4"])
        XCTAssertEqual(game.position.board["c3"], Piece(kind: .pawn, color: .black))
        
        game.make(move: "d2c3")
        game.make(move: "f7f5")
        game.make(move: "g5f6")
        XCTAssertNil(game.position.board["g5"])
        XCTAssertNil(game.position.board["f5"])
        XCTAssertEqual(game.position.board["f6"], Piece(kind: .pawn, color: .white))
    }
    
    func testPawnPromotion() throws {
        let fen = "8/1p3ppk/4p3/3p4/1p6/1K6/6p1/8 b - - 1 48"
        let position = FenSerialization.default.deserialize(fen: fen)
        let game = Game(position: position)
        
        game.make(move: "g2g1q")
        let finalFen = FenSerialization.default.serialize(position: game.position)
        
        XCTAssertEqual(finalFen, "8/1p3ppk/4p3/3p4/1p6/1K6/8/6q1 w - - 0 49")
    }
    
    func testIsCheck() throws {
        let checkPosition = FenSerialization.default.deserialize(fen: "3k4/8/8/8/5q2/8/8/5K2 w - - 0 1")
        XCTAssertTrue(StandardRules().isCheck(in: checkPosition), "Position: \(FenSerialization.default.serialize(position: checkPosition))")
        
        let notCheckPosition = FenSerialization.default.deserialize(fen: "3k4/8/8/8/8/4q3/8/5K2 w - - 0 1")
        XCTAssertFalse(StandardRules().isCheck(in: notCheckPosition), "Position: \(FenSerialization.default.serialize(position: notCheckPosition))")
    }
    
    func testIsMate() throws {
        let matePosition = FenSerialization.default.deserialize(fen: "3k3R/8/3K4/8/8/8/8/8 b - - 0 1")
        XCTAssertTrue(StandardRules().isMate(in: matePosition), "Position: \(FenSerialization.default.serialize(position: matePosition))")
        
        let checkPosition = FenSerialization.default.deserialize(fen: "3k4/8/8/8/5q2/8/8/5K2 w - - 0 1")
        XCTAssertFalse(StandardRules().isMate(in: checkPosition), "Position: \(FenSerialization.default.serialize(position: checkPosition))")
        
        let stalematePosition = FenSerialization.default.deserialize(fen: "8/8/8/8/8/6k1/5q2/7K w - - 0 1")
        XCTAssertFalse(StandardRules().isMate(in: stalematePosition), "Position: \(FenSerialization.default.serialize(position: stalematePosition))")
    }

}
