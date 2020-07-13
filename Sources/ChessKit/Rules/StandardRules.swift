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
        return self.enumeratedPieces(for: position)
            .flatMap { self.movesForPiece(at: $0.0, in: position) }
    }
    
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
        
        let moves = moving.moves(from: square, in: position)
        return self.filterIllegal(moves: moves, for: position)
    }
    
    private func coveredSquares(in position: Position) -> [Square] {
        return self.enumeratedPieces(for: position)
            .filter { $0.1.kind != .king }
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
        if moving is KingMoving {
            return []
        }
        
        return moving.coveredSquares(from: square, in: position)
    }
    
    private func filterIllegal(moves: [Move], for position: Position) -> [Move] {
        return moves.filter { (move: Move) -> Bool in
            var nextPosition = position.deepCopy()
            nextPosition.board[move.to] = nextPosition.board[move.from]
            nextPosition.board[move.from] = nil
            nextPosition.turn = nextPosition.turn.negotiated
            
            guard let kingSquare = nextPosition.board.enumeratedPieces().filter({ $0.1.kind == .king && $0.1.color == position.turn }).first?.0 else {
                return true
            }
            
            if position.board[move.from]?.kind == .king {
                if abs(move.from.file - move.to.file) > 1 {
                    var nextPosition = position.deepCopy()
                    nextPosition.turn = nextPosition.turn.negotiated
                    if self.coveredSquares(in: nextPosition).contains(move.from) {
                        return false
                    }
                    
                    let fileTranslation = (move.to.file - move.from.file) / 2
                    let squareBetween = move.from.translate(file: fileTranslation, rank: 0)

                    nextPosition = position.deepCopy()
                    nextPosition.board[squareBetween] = nextPosition.board[move.from]
                    nextPosition.board[move.from] = nil
                    nextPosition.turn = nextPosition.turn.negotiated

                    if self.coveredSquares(in: nextPosition).contains(squareBetween) {
                        return false
                    }
                }
            }
            
            return !self.coveredSquares(in: nextPosition).contains(kingSquare)
        }
    }
    
    private func enumeratedPieces(for position: Position) -> [(Square, Piece)] {
        return position.board.enumeratedPieces()
            .filter { $0.1.color == position.turn }
    }
    
}
