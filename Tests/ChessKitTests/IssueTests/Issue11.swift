//
//  Issue11.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev, 2025.
//  Copyright © 2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

func makePosition(afterMoves movesString: String) -> Position {
    let fenSerializator: FenSerialization = FenSerialization()
    let initialFen: String = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    let initialPosition: Position = fenSerializator.deserialize(fen: initialFen)

    let moves: [Move] =
        movesString
        .split(separator: " ")
        .map { Move(string: $0.description) }

    let game: Game = Game(position: initialPosition)

    moves.forEach { game.make(move: $0) }

    return game.position
}

@Test("Issue #11")
func issue11() {
    let position1: Position = makePosition(afterMoves: "e2e4 e7e5 d2d4 d7d5")
    let position2: Position = makePosition(afterMoves: "d2d4 d7d5 e2e4 e7e5")
    #expect(position1 == position2, "\(position1) != \(position2)")
}
