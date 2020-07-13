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
    
    public func legalMoves(in position: Position) -> [Move] {
        return position
            .board.enumeratedPieces()
            .filter { $0.1.color == position.turn }
            .flatMap { self.movesForPiece(at: $0.0, in: position) }
    }
    
    public func movesForPiece(at square: Square, in position: Position) -> [Move] {
        let moves = self.coveredSquaresForPiece(at: square, in: position)
            .map { Move(from: square, to: $0) }
        return self.filterIllegal(moves: moves, for: position)
    }
    
    private func coveredSquares(in position: Position) -> [Square] {
        return position
            .board.enumeratedPieces()
            .filter { $0.1.color == position.turn }
            .flatMap { self.coveredSquaresForPiece(at: $0.0, in: position) }
    }
    
    private func coveredSquaresForPiece(at square: Square, in position: Position) -> [Square] {
        guard let piece = position.board[square] else {
            return []
        }
        guard piece.color == position.turn else {
            return []
        }
        guard let moving = self.movings[piece.kind] else {
            return []
        }
        
        return moving.coveredSquares(from: square, in: position)
    }
    
    private func filterIllegal(moves: [Move], for position: Position) -> [Move] {
        let underCheckFilter = { (move: Move) -> Bool in
            var nextPosition = position.deepCopy()
            nextPosition.board[move.to] = nextPosition.board[move.from]
            nextPosition.board[move.from] = nil
            nextPosition.turn = nextPosition.turn.negotiated
            
            guard let kingSquare = nextPosition.board.enumeratedPieces().filter({ $0.1.kind == .king && $0.1.color == position.turn }).first?.0 else {
                return true
            }
            
            return !self.coveredSquares(in: nextPosition).contains(kingSquare)
        }
        
        return moves.filter(underCheckFilter)
    }
    
}
