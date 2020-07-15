//
//  StandardRules.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Standard chess move rules.
class StandardRules: Rules {
    
    private let movings: [PieceKind:PieceMoving] = [
        .king: KingMoving(),
        .queen: QueenMoving(),
        .rook: RookMoving(),
        .bishop: BishopMoving(),
        .knight: KnightMoving(),
        .pawn: PawnMoving()
    ]
    
    func isCheck(in position: Position) -> Bool {
        guard let kingSquare = self.kingSquare(in: position, color: position.state.turn) else {
            return false
        }
        
        var nextMovePosition = position.deepCopy()
        nextMovePosition.state.turn = nextMovePosition.state.turn.negotiated
        let coveredSquares = self.coveredSquares(in: nextMovePosition)
        
        return coveredSquares.contains(kingSquare)
    }
    
    func isMate(in position: Position) -> Bool {
        guard self.isCheck(in: position) else {
            return false
        }
        guard let kingSquare = self.kingSquare(in: position, color: position.state.turn) else {
            return false
        }
        return self.movesForPiece(at: kingSquare, in: position).isEmpty
    }
    
    func legalMoves(in position: Position) -> [Move] {
        return self.enumeratedPieces(for: position)
            .flatMap { self.movesForPiece(at: $0.0, in: position) }
    }
    
    func movesForPiece(at square: Square, in position: Position) -> [Move] {
        guard let piece = position.board[square] else {
            return []
        }
        guard piece.color == position.state.turn else {
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
        guard piece.color == position.state.turn else {
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
        let filter = { (move: Move) -> Bool in
            var nextPosition = position.deepCopy()
            nextPosition.board[move.to] = nextPosition.board[move.from]
            nextPosition.board[move.from] = nil
            nextPosition.state.turn = nextPosition.state.turn.negotiated
            
            guard let kingSquare = self.kingSquare(in: nextPosition, color: position.state.turn) else {
                return true
            }
            
            if self.isIllelgalCastling(move: move, position: position) {
                return false
            }
            
            return !self.coveredSquares(in: nextPosition).contains(kingSquare)
        }
        
        return moves.filter(filter)
    }
    
    private func enumeratedPieces(for position: Position) -> [(Square, Piece)] {
        return position.board.enumeratedPieces()
            .filter { $0.1.color == position.state.turn }
    }
    
    private func kingSquare(in position: Position, color: PieceColor) -> Square? {
        return position.board.enumeratedPieces()
            .filter({ $0.1.kind == .king && $0.1.color == color })
            .first?.0
    }
    
    private func isIllelgalCastling(move: Move, position: Position) -> Bool {
        guard position.board[move.from]?.kind == .king else {
            return false
        }
        guard abs(move.from.file - move.to.file) > 1 else {
            return false
        }
        if self.isCatslingToCheck(move: move, position: position) {
            return true
        }
        if self.isCastlingThroughCheck(move: move, position: position) {
            return true
        }
        return false
    }
    
    private func isCastlingThroughCheck(move: Move, position: Position) -> Bool {
        let fileTranslation = (move.to.file - move.from.file) / 2
        let squareBetween = move.from.translate(file: fileTranslation, rank: 0)

        var nextPosition = position.deepCopy()
        nextPosition.board[squareBetween] = nextPosition.board[move.from]
        nextPosition.board[move.from] = nil
        nextPosition.state.turn = nextPosition.state.turn.negotiated

        if self.coveredSquares(in: nextPosition).contains(squareBetween) {
            return true
        }
        
        return false
    }
    
    private func isCatslingToCheck(move: Move, position: Position) -> Bool {
        var nextPosition = position.deepCopy()
        nextPosition.state.turn = nextPosition.state.turn.negotiated
        if self.coveredSquares(in: nextPosition).contains(move.from) {
            return true
        }
        return false
    }
    
}
