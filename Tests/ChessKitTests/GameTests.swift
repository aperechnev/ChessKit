//
//  GameTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Modified by Alexander Perechnev on 30.09.2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test func movesHistory() {
    let fenSerializator = FenSerialization()
    let fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    let position = fenSerializator.deserialize(fen: fen)
    let game = Game(position: position)

    let moves = ["e2e4", "e7e5", "g1f3", "b8c6", "d2d4", "e5d4"]
        .map { Move(string: $0) }

    moves.forEach { game.make(move: $0) }

    #expect(moves == game.movesHistory)

    #expect(
        "r1bqkbnr/pppp1ppp/2n5/8/3pP3/5N2/PPP2PPP/RNBQKB1R w KQkq - 0 4"
            == fenSerializator.serialize(position: game.position)
    )
}

@Test func positionsCounter() {
    let fenSerializator = FenSerialization()
    let fen = "1K2Q3/8/8/6p1/5pk1/8/7P/8 w - - 3 66"
    let position = fenSerializator.deserialize(fen: fen)
    let game = Game(position: position)

    #expect(game.positionsCounter[game.position.board] == 1)

    game.make(move: "b8a8")
    game.make(move: "g4f3")
    game.make(move: "a8b8")
    game.make(move: "f3g4")
    #expect(game.positionsCounter[game.position.board] == 2)

    game.make(move: "b8a8")
    game.make(move: "g4f3")
    game.make(move: "a8b8")
    game.make(move: "f3g4")
    #expect(game.positionsCounter[game.position.board] == 3)
}

@Test func simpleMove() {
    let fenSerializator = FenSerialization()
    let initialFen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    let position = fenSerializator.deserialize(fen: initialFen)
    let rules = StandardRules()
    let game = Game(position: position, rules: rules)

    game.make(move: "e2e4")
    #expect(game.position.board["e4"] == Piece(kind: .pawn, color: .white))
    #expect(game.position.board["e2"] == nil)
    #expect(game.position.state.turn == PieceColor.black)
    #expect(game.position.state.enPasant == Square(coordinate: "e3"))
    #expect(game.position.counter.fullMoves == 1)

    game.make(move: "d7d5")
    #expect(game.position.state.turn == PieceColor.white)
    #expect(game.position.state.enPasant == Square(coordinate: "d6"))
    #expect(game.position.counter.fullMoves == 2)

    game.make(move: "g1f3")
    #expect(game.position.state.enPasant == nil)
    #expect(game.position.counter.halfMoves == 1)
}

@Test func loosingKingCastling() {
    let fenSerializator = FenSerialization()
    let fen = "r1bqk1nr/pppp1ppp/2n5/2b5/2BpP3/5N2/PPP2PPP/RNBQK2R w KQkq - 2 5"
    let position = fenSerializator.deserialize(fen: fen)
    let rules = StandardRules()
    let game = Game(position: position, rules: rules)

    #expect(game.position.state.castlings.contains(Piece(kind: .king, color: .white)) == true)

    game.make(move: "h1g1")
    #expect(game.position.state.castlings.contains(Piece(kind: .king, color: .white)) == false)
}

@Test func loosingQueenCastling() {
    let fenSerializator = FenSerialization()
    let fen = "4k3/8/8/8/8/8/8/R3K2R w KQ - 0 1"
    let position = fenSerializator.deserialize(fen: fen)
    let rules = StandardRules()
    let game = Game(position: position, rules: rules)

    #expect(game.position.state.castlings.contains(Piece(kind: .queen, color: .white)) == true)

    game.make(move: "a1b1")
    #expect(game.position.state.castlings.contains(Piece(kind: .queen, color: .white)) == false)
}

@Test func loosingAllCastlings() {
    let fenSerializator = FenSerialization()
    let fen = "4k3/8/8/8/8/8/8/R3K2R w KQ - 0 1"
    let position = fenSerializator.deserialize(fen: fen)
    let rules = StandardRules()
    let game = Game(position: position, rules: rules)

    #expect(game.position.state.castlings.contains(Piece(kind: .queen, color: .white)) == true)
    #expect(game.position.state.castlings.contains(Piece(kind: .king, color: .white)) == true)

    game.make(move: "e1e2")
    #expect(game.position.state.castlings.contains(Piece(kind: .queen, color: .white)) == false)
    #expect(game.position.state.castlings.contains(Piece(kind: .king, color: .white)) == false)
}

@Test func kingCastling() {
    let fenSerializator = FenSerialization()
    let fen = "4k3/8/8/8/8/8/8/R3K2R w KQ - 0 1"
    let position = fenSerializator.deserialize(fen: fen)
    let rules = StandardRules()
    let game = Game(position: position, rules: rules)

    game.make(move: "e1g1")

    #expect(game.position.board["e1"] == nil)
    #expect(game.position.board["f1"] == Piece(kind: .rook, color: .white))
    #expect(game.position.board["g1"] == Piece(kind: .king, color: .white))
    #expect(game.position.board["h1"] == nil)
}

@Test func queenCastling() {
    let fenSerializator = FenSerialization()
    let fen = "4k3/8/8/8/8/8/8/R3K2R w KQ - 0 1"
    let position = fenSerializator.deserialize(fen: fen)
    let rules = StandardRules()
    let game = Game(position: position, rules: rules)

    game.make(move: "e1c1")

    #expect(game.position.board["a1"] == nil)
    #expect(game.position.board["b1"] == nil)
    #expect(game.position.board["c1"] == Piece(kind: .king, color: .white))
    #expect(game.position.board["d1"] == Piece(kind: .rook, color: .white))
    #expect(game.position.board["e1"] == nil)
}

@Test func enPassantTaking() {
    let fenSerializator = FenSerialization()
    let fen = "rnbqkbnr/p1pppppp/8/6P1/1pP5/8/PP1PPP1P/RNBQKBNR b KQkq c3 0 3"
    let position = fenSerializator.deserialize(fen: fen)
    let rules = StandardRules()
    let game = Game(position: position, rules: rules)

    game.make(move: "b4c3")
    #expect(game.position.board["b4"] == nil)
    #expect(game.position.board["c4"] == nil)
    #expect(game.position.board["c3"] == Piece(kind: .pawn, color: .black))

    game.make(move: "d2c3")
    game.make(move: "f7f5")
    game.make(move: "g5f6")
    #expect(game.position.board["g5"] == nil)
    #expect(game.position.board["f5"] == nil)
    #expect(game.position.board["f6"] == Piece(kind: .pawn, color: .white))
}

@Test func pawnPromotion() {
    let fenSerializator = FenSerialization()
    let fen = "8/1p3ppk/4p3/3p4/1p6/1K6/6p1/8 b - - 1 48"
    let position = fenSerializator.deserialize(fen: fen)
    let game = Game(position: position)

    game.make(move: "g2g1q")
    let finalFen = fenSerializator.serialize(position: game.position)

    #expect(finalFen == "8/1p3ppk/4p3/3p4/1p6/1K6/8/6q1 w - - 0 49")
}

@Test func isCheck() {
    let fenSerializator = FenSerialization()
    let checkPosition = fenSerializator.deserialize(
        fen: "3k4/8/8/8/5q2/8/8/5K2 w - - 0 1")
    #expect(
        StandardRules().isCheck(in: checkPosition) == true,
        "Position: \(fenSerializator.serialize(position: checkPosition))")

    let notCheckPosition = fenSerializator.deserialize(
        fen: "3k4/8/8/8/8/4q3/8/5K2 w - - 0 1")
    #expect(
        StandardRules().isCheck(in: notCheckPosition) == false,
        "Position: \(fenSerializator.serialize(position: notCheckPosition))")
}

@Test func isMate() {
    let fenSerializator = FenSerialization()
    let matePosition = fenSerializator.deserialize(
        fen: "3k3R/8/3K4/8/8/8/8/8 b - - 0 1")
    #expect(
        StandardRules().isMate(in: matePosition) == true,
        "Position: \(fenSerializator.serialize(position: matePosition))")

    let checkPosition = fenSerializator.deserialize(
        fen: "3k4/8/8/8/5q2/8/8/5K2 w - - 0 1")
    #expect(
        StandardRules().isMate(in: checkPosition) == false,
        "Position: \(fenSerializator.serialize(position: checkPosition))")

    let stalematePosition = fenSerializator.deserialize(
        fen: "8/8/8/8/8/6k1/5q2/7K w - - 0 1")
    #expect(
        StandardRules().isMate(in: stalematePosition) == false,
        "Position: \(fenSerializator.serialize(position: stalematePosition))")
}
