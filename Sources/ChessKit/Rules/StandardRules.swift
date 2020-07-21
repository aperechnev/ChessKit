//
//  StandardRules.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Standard chess move rules.
public class StandardRules: Rules {
    
    private let movings: [PieceKind:PieceMoving]
    
    /// Initialise a new instance.
    public init() {
        self.movings = [
            .king: KingMoving(),
            .queen: QueenMoving(),
            .rook: RookMoving(),
            .bishop: BishopMoving(),
            .knight: KnightMoving(),
            .pawn: PawnMoving()
        ]
    }
    
    func isCheck(in position: Position) -> Bool {
        guard let kingSquare = self.kingSquare(in: position, color: position.state.turn) else {
            return false
        }
        
        let bitboards = position.board.bitboards
        
        for translation in MovingTranslations.default.diagonal {
            for offset in 1..<8 {
                let destination = kingSquare.translate(file: translation.0 * offset, rank: translation.1 * offset)
                guard destination.isValid else {
                    break
                }
                
                if (bitboards.white | bitboards.black) & destination.bitboardMask == Int64.zero {
                    continue
                }
                if bitboards.bitboard(for: position.state.turn) & destination.bitboardMask != Int64.zero {
                    break
                }
                
                if (bitboards.queen | bitboards.bishop) & destination.bitboardMask == Int64.zero {
                    break
                } else {
                    return true
                }
            }
        }
        
        for translation in MovingTranslations.default.cross {
            for offset in 1..<8 {
                let destination = kingSquare.translate(file: translation.0 * offset, rank: translation.1 * offset)
                guard destination.isValid else {
                    break
                }
                if bitboards.bitboard(for: position.state.turn) & destination.bitboardMask != Int64.zero {
                    break
                }
                
                if (bitboards.white | bitboards.black) & destination.bitboardMask == Int64.zero {
                    continue
                }
                
                if (bitboards.queen | bitboards.rook) & destination.bitboardMask != Int64.zero {
                    return true
                } else {
                    break
                }
            }
        }
        
        for translation in MovingTranslations.default.knight {
            let destination = kingSquare.translate(file: translation.0, rank: translation.1)
            guard destination.isValid else {
                continue
            }
            if bitboards.bitboard(for: position.state.turn.negotiated) & bitboards.knight & destination.bitboardMask != Int64.zero {
                return true
            }
        }
        
        for translation in MovingTranslations.default.pawnTaking {
            let sign = position.state.turn == .white ? 1 : -1
            let destination = kingSquare.translate(file: translation.0, rank: translation.1 * sign)
            guard destination.isValid else {
                continue
            }
            if bitboards.pawn & bitboards.bitboard(for: position.state.turn.negotiated) & destination.bitboardMask != Int64.zero {
                return true
            }
        }
        
        return false
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
    
    /**
     Generates available moves from square in given position.
     
     - Parameters:
        - square: Square of the piece.
        - position: Position.
     
     - Returns: List of available moves.
     */
    public func movesForPiece(at square: Square, in position: Position) -> [Move] {
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
    
    public func coveredSquares(in position: Position) -> [Square] {
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
            var nextPosition = position
            nextPosition.board[move.to] = nextPosition.board[move.from]
            nextPosition.board[move.from] = nil
            
            if self.isIllelgalCastling(move: move, position: position) {
                return false
            }
            
            return !self.isCheck(in: nextPosition)
        }
        
        return moves.filter(filter)
    }
    
    private func enumeratedPieces(for position: Position) -> [(Square, Piece)] {
        return position.board.enumeratedPieces()
            .filter { $0.1.color == position.state.turn }
    }
    
    private func kingSquare(in position: Position, color: PieceColor) -> Square? {
        let mask = position.board.bitboards.king & position.board.bitboards.bitboard(for: color)
        let square = Square(bitboardMask: mask)
        return square.isValid ? square : nil
    }
    
    private func isIllelgalCastling(move: Move, position: Position) -> Bool {
        guard position.board.bitboards.king & move.from.bitboardMask != Int64.zero else {
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

        var nextPosition = position
        nextPosition.board[squareBetween] = nextPosition.board[move.from]
        nextPosition.board[move.from] = nil
        nextPosition.state.turn = nextPosition.state.turn.negotiated

        if self.coveredSquares(in: nextPosition).contains(squareBetween) {
            return true
        }
        
        return false
    }
    
    private func isCatslingToCheck(move: Move, position: Position) -> Bool {
        var nextPosition = position
        nextPosition.state.turn = nextPosition.state.turn.negotiated
        if self.coveredSquares(in: nextPosition).contains(move.from) {
            return true
        }
        return false
    }
    
}
