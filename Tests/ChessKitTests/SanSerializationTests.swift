//
//  SanSerializationTests.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 02.03.2021.
//

import XCTest
@testable import ChessKit

class SanSerializationTests: XCTestCase {
    
    private let testables: [(String, String, String)] = [
        // Pawn move
        ("e4", "e2e4", "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"),

        // Simple piece moves
        ("Nc6", "b8c6", "rnbqkbnr/pppp1ppp/8/4p3/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2"),
        ("Re1", "f1e1", "r1b1kb1r/ppppqppp/2n5/4P3/2Bpn3/5N2/PPP2PPP/RNBQ1RK1 w kq - 1 7"),

        // Piece moves with variations
        ("Nbd4", "b3d4", "1n2k1n1/8/8/8/8/1N3N2/8/4K3 w - - 0 1"),
        ("Nfd4", "f3d4", "1n2k1n1/8/8/8/8/1N3N2/8/4K3 w - - 0 1"),
        ("Nbd2", "b1d2", "r1b1kb1r/pppp1pp1/1qn4p/4P3/3p2nB/1B3N2/PPP2PPP/RN1Q1RK1 w kq - 2 10"),

        // Taking by piece
        ("Nxe5", "c6e5", "r1bqkbnr/pppp1ppp/2n5/4N3/4P3/8/PPPP1PPP/RNBQKB1R b KQkq - 0 3"),
        ("Nbxd4", "b3d4", "1n2k1n1/8/8/8/3p4/1N3N2/8/4K3 w - - 0 1"),
        ("Nfxd4", "f3d4", "1n2k1n1/8/8/8/3p4/1N3N2/8/4K3 w - - 0 1"),
        ("N1xf3", "g1f3", "4k3/8/8/6N1/8/5p2/8/4K1N1 w - - 0 1"),
        ("N5xf3", "g5f3", "4k3/8/8/6N1/8/5p2/8/4K1N1 w - - 0 1"),

        // Taking by pawn
        ("exd4", "e5d4", "r1bqkbnr/pppp1ppp/2n5/4p3/3PP3/5N2/PPP2PPP/RNBQKB1R b KQkq - 0 3"),
        ("exf6", "e5f6", "r1bqkb1r/pppppppp/2n2n2/4P3/8/8/PPPP1PPP/RNBQKBNR w KQkq - 1 3"),
        ("bxc6", "b7c6", "4kb1r/1p1n1pp1/1qR1p1n1/p2p4/3P3p/1P3N1P/P2N1PPB/3Q1RK1 b k - 0 17"),

        // Castling
        ("O-O", "e1g1", "r2q1rk1/ppp1bppp/2np1n2/4p3/2BPP1b1/2N1BN2/PPP1QPPP/R3K2R w KQ - 8 8"),
        ("O-O-O", "e1c1", "r2q1rk1/ppp1bppp/2np1n2/4p3/2BPP1b1/2N1BN2/PPP1QPPP/R3K2R w KQ - 8 8"),
        
        // Check
        ("Qe6+", "f5e6", "rnb1kbnr/ppp1pppp/8/5q2/3P4/5N2/PPP2PPP/RNBQKB1R b KQkq - 2 4"),
        ("d7+", "d6d7", "4k3/8/3P4/8/8/8/8/4K3 w - - 0 1"),
        ("O-O-O+", "e1c1", "3k4/8/8/8/8/8/8/R3K3 w Q - 0 1"),
    ]
    
    // MARK: - Serialization
    
    func testSerialization() throws {
        self.testables.forEach {
            XCTAssertEqual($0.0, self.san(for: $0.1, in: $0.2))
        }
    }
    
    private func san(for move: String, in fen: String) -> String {
        let position = FenSerialization.default.deserialize(fen: fen)
        let game = Game(position: position)
        let move = Move(string: move)
        return SanSerialization.default.san(for: move, in: game)
    }
    
    // MARK: - Deserialization
    
    func testDeserialization() throws {
        self.testables.forEach {
            XCTAssertEqual($0.1, self.move(from: $0.0, in: $0.2))
        }
    }
    
    private func move(from san: String, in fen: String) -> String {
        let position = FenSerialization.default.deserialize(fen: fen)
        let game = Game(position: position)
        return SanSerialization.default.move(for: san, in: game).description
    }
    
}
