//
//  StandardRules.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

public class StandardRules: Rules {
    
    private let movings: [PieceKind:PieceMoving] = [
        .king: KingMoving(),
        .queen: QueenMoving(),
        .rook: RookMoving(),
        .bishop: BishopMoving(),
        .knight: KnightMoving(),
        .pawn: PawnMoving()
    ]
    
    public func movesForPiece(at square: Square, in position: Position) -> [Move] {
        guard let piece = position.board[square] else {
            return []
        }
        guard piece.color == position.turn else {
            return []
        }
        guard let moving = self.movings[piece.kind] else {
            return []
        }
        return moving.moves(from: square, in: position)
    }
    
    public func legalMoves(in position: Position) -> [Move] {
        return position
            .board.enumeratedPieces()
            .filter { $0.1.color == position.turn }
            .flatMap { self.movesForPiece(at: $0.0, in: position) }
    }
    
}
