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

}
