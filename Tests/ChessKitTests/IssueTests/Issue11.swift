//
//  Issue11.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev, 2025.
//  Copyright © 2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

func makePositionWithCorrectEnPassant(afterMoves movesString: String) -> Position {
    let fenSerializator: FenSerialization = FenSerialization()
    let initialFen: String = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    let initialPosition: Position = fenSerializator.deserialize(fen: initialFen)

    let moves: [Move] =
        movesString
        .split(separator: " ")
        .map { Move(string: $0.description) }

    let game: Game = Game(position: initialPosition)
    moves.forEach(game.make(move:))

    return game.positionWithCorrectEnPassant()
}

@Test("Positions with correct en-passant: both with no en-passant")
func bothWithNoEnPassant() {
    let position1: Position = makePositionWithCorrectEnPassant(afterMoves: "e2e4 e7e5 d2d4 d7d5")
    let position2: Position = makePositionWithCorrectEnPassant(afterMoves: "d2d4 d7d5 e2e4 e7e5")
    #expect(position1 == position2, "\(position1) != \(position2)")
}

@Test("Positions with correct en-passant: one with en-passant")
func oneWithEnPassant() {
    let position1: Position = makePositionWithCorrectEnPassant(
        afterMoves: "e2e4 b7b5 h2h3 h7h6 a2a4 b5b4 e4e5")
    let position2: Position = makePositionWithCorrectEnPassant(
        afterMoves: "e2e4 b7b5 e4e5 h7h6 h2h3 b5b4 a2a4")

    #expect(position1 != position2, "\(position1) == \(position2)")
    #expect(position1.state.enPasant == nil)
    #expect(
        position2.state.enPasant?.description == "a3",
        "En-passant: \(position2.state.enPasant?.description ?? "nil")")
}
