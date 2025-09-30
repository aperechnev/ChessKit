//
//  PawnMovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Modified by Alexander Perechnev on 30.09.2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit


@Test(
    "Pawn moves test",
    arguments: [
        // Alone
        ("8/8/8/8/8/8/4P3/8 w - - 0 1", "e2e3 e2e4", "e2"),
        ("8/5p2/8/8/8/8/8/8 b - - 0 1", "f7f6 f7f5", "f7"),
        ("8/8/8/4P3/8/8/8/8 w - - 0 1", "e5e6", "e5"),
        ("8/8/8/2p5/8/8/8/8 b - - 0 1", "c5c4", "c5"),
        ("8/8/8/8/8/5N2/5P2/8 w - - 0 1", "", "f2"),
        ("8/2p5/2q5/8/8/8/8/8 b - - 0 1", "", "c7"),
        // Piece taking
        ("8/8/8/8/3n4/5n2/4P3/8 w - - 0 1", "e2e3 e2e4 e2f3", "e2"),
        ("8/8/5n2/4P3/8/8/8/8 w - - 0 1", "e5e6 e5f6", "e5"),
        ("8/p7/1N6/8/8/8/8/8 b - - 0 1", "a7a6 a7a5 a7b6", "a7"),
        ("8/8/8/8/8/3p4/4N3/8 b - - 0 1", "d3d2 d3e2", "d3"),
        // Promotion
        ("3n4/4P3/8/8/8/8/8/8 w - - 0 1", "e7d8Q e7d8R e7d8B e7d8N e7e8Q e7e8R e7e8B e7e8N", "e7"),
        ("3nr3/4P3/8/8/8/8/8/8 w - - 0 1", "e7d8Q e7d8R e7d8B e7d8N", "e7"),
        ("8/8/8/8/8/8/2p5/3B4 b - - 0 1", "c2c1q c2c1r c2c1b c2c1n c2d1q c2d1r c2d1b c2d1n", "c2"),
        ("8/8/8/8/8/8/2p5/2RB4 b - - 0 1", "c2d1q c2d1r c2d1b c2d1n", "c2"),
        // En-passant
        ("rnbqkbnr/pp2pppp/2p5/3pP3/8/8/PPPP1PPP/RNBQKBNR w KQkq d6 0 3", "e5e6 e5d6", "e5"),
        ("rnbqkbnr/ppp1pppp/8/8/3pP1P1/7P/PPPP1P2/RNBQKBNR b KQkq e3 0 3", "d4d3 d4e3", "d4"),
        ("8/8/3p2k1/P2Pr1Pp/3R2KP/8/8/8 w - h6 0 2", "g5h6", "g5"),
    ])
func assert(fen: String, moves: String, coordinate: String) {
    let position = FenSerialization.default.deserialize(fen: fen)
    let square = Square(coordinate: coordinate)
    let moves = moves.split(separator: " ").map { "\($0)" }
    let testMoves = StandardRules().movesForPiece(at: square, in: position)

    #expect(
        moves.map({ $0.lowercased() }).sorted()
            == testMoves.map({ $0.description.lowercased() }).sorted(),
        "Position: \(fen)"
    )
}
