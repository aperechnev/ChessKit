//
//  MovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 30.09.2025.
//  Modified by Alexander Perechnev on 30.09.2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test(
    "Available piece moves",
    arguments: [
        // Rook
        ("8/8/8/3R4/8/8/8/8 w - - 0 1", "a5 b5 c5 e5 f5 g5 h5 d1 d2 d3 d4 d6 d7 d8", "d5"),  // Alone at the center
        ("7R/8/8/8/8/8/8/8 w - - 0 1", "a8 b8 c8 d8 e8 f8 g8 h1 h2 h3 h4 h5 h6 h7", "h8"),  // Alone at the top right corner
        ("8/3P4/8/3RP3/8/8/3N4/8 w - - 0 1", "a5 b5 c5 d3 d4 d6", "d5"),  // Surrounded by pieces with same color
        ("8/3p4/8/3Rp3/8/8/3n4/8 w - - 0 1", "a5 b5 c5 e5 d2 d3 d4 d6 d7", "d5"),  // Taking a piece

        // Bishop
        ("8/8/8/4b3/8/8/8/8 b - - 0 1", "a1 b2 c3 d4 f6 g7 h8 b8 c7 d6 f4 g3 h2", "e5"),  // Alone at the center
        ("7b/8/8/8/8/8/8/8 b - - 0 1", "a1 b2 c3 d4 e5 f6 g7", "h8"),  // Alone at the top right corner
        ("8/1k6/8/3b4/2r5/8/8/7p b - - 0 1", "e6 f7 g8 c6 e4 f3 g2", "d5"),  // Surrounded by pieces with same color
        ("8/1Q6/8/3b4/2R5/8/6P1/8 b - - 0 1", "c4 e6 f7 g8 b7 c6 e4 f3 g2", "d5"),  // Taking a piece

        // Queen
        (
            "8/8/8/4q3/8/8/8/8 b - - 0 1",
            "e1 e2 e3 e4 e6 e7 e8 a5 b5 c5 d5 f5 g5 h5 a1 b2 c3 d4 f6 g7 h8 b8 c7 d6 f4 g3 h2", "e5"
        ),  // Alone at the center
        (
            "7q/8/8/8/8/8/8/8 b - - 0 1",
            "a8 b8 c8 d8 e8 f8 g8 a1 b2 c3 d4 e5 f6 g7 h1 h2 h3 h4 h5 h6 h7", "h8"
        ),  // Alone at the top right corner
        (
            "8/4n3/5q2/8/3p4/8/5p2/8 b - - 0 1",
            "a6 b6 c6 d6 e6 g6 h6 f3 f4 f5 f7 f8 e5 g7 h8 g5 h4", "f6"
        ),  // Surrounded by pieces with the same color
        (
            "8/4N3/5q2/8/3P4/8/5P2/8 b - - 0 1",
            "a6 b6 c6 d6 e6 g6 h6 f2 f3 f4 f5 f7 f8 d4 e5 g7 h8 e7 g5 h4", "f6"
        ),  // Taking a piece

        // Knight
        ("8/8/8/4N3/8/8/8/8 w - - 0 1", "c6 d7 f7 g6 g4 f3 d3 c4", "e5"),  // Alone at the center
        ("7N/8/8/8/8/8/8/8 w - - 0 1", "f7 g6", "h8"),  // Alone at the top right corner
        ("8/5P2/2K5/4N3/8/3R4/8/8 w - - 0 1", "d7 g6 g4 f3 c4", "e5"),  // Surrounded by pieces with same color
        ("8/5p2/2k5/4N3/8/3r4/8/8 w - - 0 1", "c6 d7 f7 g6 g4 f3 d3 c4", "e5"),  // Taking a piece

        // King
        ("8/8/8/8/4K3/8/8/8 w - - 0 1", "d5 e5 f5 d4 f4 d3 e3 f3", "e4"),  // Alone at the center
        ("K7/8/8/8/8/8/8/8 w - - 0 1", "a7 b7 b8", "a8"),  // Alone at the top left corner
        ("7K/8/8/8/8/8/8/8 w - - 0 1", "g8 g7 h7", "h8"),  // Alone at the top right corner
        ("8/8/8/8/8/8/8/7K w - - 0 1", "g1 g2 h2", "h1"),  // Alone at the bottom right corner
        ("8/8/8/8/8/8/8/K7 w - - 0 1", "a2 b2 b1", "a1"),  // Alone at the bottom left corner
        ("8/8/8/3PPP2/3PKP2/3PPP2/8/8 w - - 0 1", "", "e4"),  // Stuck with pieces with the same color
        ("8/8/8/3PP3/3PK3/3P1P2/8/8 w - - 0 1", "f5 f4 e3", "e4"),  // Surrounded by pieces with the same color
        ("8/8/8/3r4/4K3/8/8/8 w - - 0 1", "e3 f3 f4 d5", "e4"),  // Taking a piece
        ("8/8/3k4/8/4K3/8/8/8 w - - 0 1", "f5 f4 f3 e3 d3 d4", "e4"),  // Behind the opposite king
        ("8/8/3k4/8/3K4/8/8/8 w - - 0 1", "c4 c3 d3 e3 e4", "d4"),
        ("8/8/3k4/8/5K2/8/8/8 w - - 0 1", "f5 g5 g4 g3 f3 e3 e4", "f4"),
        ("r1bqkbnr/pppp1ppp/2n5/8/3pP3/5N2/PPP2PPP/RNBQKB1R w KQkq - 0 4", "d2 e2", "e1"),  // Kingside castling
        ("r1bqk1nr/pppp1ppp/2n5/2b5/2BpP3/5N2/PPP2PPP/RNBQK2R w KQkq - 2 5", "d2 e2 f1 g1", "e1"),
        ("r1b1k2r/ppppqppp/2n2n2/2b5/2BpP3/5N2/PPP2PPP/RNBQK2R w kq - 6 7", "d2 e2 f1", "e1"),
        ("r1b1k2r/ppppqppp/2n2n2/2b5/2BpP3/2N2N2/PPP2PPP/R1BQK2R b kq - 7 7", "d8 f8 g8", "e8"),
        ("r1b1kbnr/ppp1qppp/2np4/4p3/3PP3/2N5/PPP1QPPP/R1B1KBNR w KQkq - 4 5", "d1 d2", "e1"),  // Queenside castling
        ("r3kbnr/ppp1qppp/2npb3/4p3/3PP3/2N1B3/PPP1QPPP/R3KBNR w KQkq - 6 6", "d1 d2 c1", "e1"),
        ("r3kbnr/ppp1qppp/2npb3/4p3/3PP3/2N1B3/PPP1QPPP/R2K1BNR b kq - 7 6", "d7 d8 c8", "e8"),
        ("r2k1bnr/ppp1qppp/2npb3/4p3/3PP3/2N1B3/PPP1QPPP/R2K1BNR w - - 8 7", "c1 d2 e1", "d1"),
        ("3kr3/8/8/8/8/8/8/R3K2R w KQ - 0 1", "d1 d2 f1 f2", "e1"),  // Castling under check
        ("3rkr2/8/8/8/8/8/8/R3K2R w KQ - 0 1", "e2", "e1"),  // Castling through check
        ("8/8/8/8/8/8/2k5/R3K3 w Q - 0 1", "e2 f2 f1", "e1"),  // Castling behind the opposite king
    ])
func availablePieceMoves(fen: String, targets: String, at coordinate: String) async throws {
    let position = FenSerialization.default.deserialize(fen: fen)
    let square = Square(coordinate: coordinate)
    let moves = targets.split(separator: " ").map { "\(square)\($0)" }
    let testMoves = StandardRules().movesForPiece(at: square, in: position)
    #expect(moves.sorted() == testMoves.map({ $0.description }).sorted(), "Position: \(fen)")
}

@Test(
    "Available position moves",
    arguments: [
        // Check
        ("8/8/8/3q4/4K3/8/8/8 w - - 0 1", "e4d5 e4f4 e4e3"),  // Check by a queen
        ("8/8/8/3r4/4K3/8/8/8 w - - 0 1", "e4d5 e4f4 e4f3 e4e3"),  // Check by a rook
        ("8/8/8/3b4/4K3/8/8/8 w - - 0 1", "e4d5 e4e5 e4f5 e4f4 e4e3 e4d3 e4d4"),  // Check by a bishop
        ("8/8/8/3n4/4K3/8/8/8 w - - 0 1", "e4d5 e4e5 e4f5 e4f3 e4d3 e4d4"),  // Check by a knight
        ("8/8/3p4/8/3K4/8/8/8 w - - 0 1", "d4d5 d4e4 d4e3 d4d3 d4c3 d4c4"),  // Check by a pawn
        ("8/3p4/8/8/3K4/8/8/8 w - - 0 1", "d4c5 d4d5 d4e5 d4e4 d4e3 d4d3 d4c3 d4c4"),
        ("8/3p4/8/4K3/8/8/8/8 w - - 0 1", "e5d6 e5f6 e5f5 e5f4 e5e4 e5d4 e5d5"),
        ("3kr3/8/8/8/8/8/4Q3/4K3 w - - 0 1", "e1d1 e1d2 e1f2 e1f1 e2e3 e2e4 e2e5 e2e6 e2e7 e2e8"),  // Pinned piece
        ("3kr3/8/8/8/8/8/8/4K3 w - - 0 1", "e1d1 e1d2 e1f1 e1f2"),  // King going under check
        ("3k4/8/8/8/8/5q2/8/6K1 w - - 0 1", "g1h2"),  // King going to check
        ("2rrr3/8/1k6/8/8/8/7R/3K4 w - - 0 1", "h2d2"),  // Cover by piece

        // Scotch game
        (
            "r1bqkbnr/pppp1ppp/2n5/8/3pP3/5N2/PPP2PPP/RNBQKB1R w KQkq - 0 4",
            "a2a3 a2a4 b2b3 b2b4 c2c3 c2c4 e4e5 g2g3 g2g4 h2h3 h2h4 b1a3 b1c3 b1d2 c1d2 c1e3 c1f4 c1g5 c1h6 d1d2 d1d3 d1d4 d1e2 e1d2 e1e2 f1e2 f1d3 f1c4 f1b5 f1a6 f3d2 f3d4 f3e5 f3g5 f3h4 f3g1 h1g1"
        ),
        // Caro-Kann
        (
            "rnbqkbnr/pp2pppp/2p5/3pP3/3P4/8/PPP2PPP/RNBQKBNR b KQkq - 0 3",
            "h7h6 h7h5 g7g6 g7g5 f7f6 f7f5 e7e6 c6c5 b7b6 b7b5 a7a6 a7a5 g8h6 g8f6 e8d7 d8d7 d8d6 d8c7 d8b6 d8a5 c8d7 c8e6 c8f5 c8g4 c8h3 b8d7 b8a6"
        ),
    ])
func availablePositionMoves(fen: String, testMoves: String) {
    let position = FenSerialization.default.deserialize(fen: fen)
    let testMoves = testMoves.split(separator: " ").map { "\($0)" }
    let legalMoves = StandardRules().legalMoves(in: position)
    let legalMoveStrings = legalMoves.map({ $0.description }).sorted()
    #expect(legalMoveStrings == testMoves.sorted(), "Position: \(fen)")
}
