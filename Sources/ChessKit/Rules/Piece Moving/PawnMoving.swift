//
//  PawnMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class PawnMoving: PieceMoving {
    
    func moves(from square: Square, in position: Position) -> [Move] {
        let destinations = self.coveredSquares(from: square, in: position)
        return self.promotedMoves(from: square, in: position, destinations: destinations)
    }
    
    func coveredSquares(from square: Square, in position: Position) -> [Square] {
        return self.oneSquareMoves(from: square, in: position) +
            self.twoSquareMoves(from: square, in: position) +
            self.takingMoves(from: square, in: position) +
            self.enPassantMoves(from: square, in: position)
    }
    
    private func oneSquareMoves(from square: Square, in position: Position) -> [Square] {
        let direction = position.state.turn == .white ? 1 : -1
        let destination = square.translate(file: 0, rank: direction)
        if destination.isValid {
            if (position.board.bitboards.white | position.board.bitboards.black) & destination.bitboardMask == Int64.zero {
                return [destination]
            }
        }
        return []
    }
    
    private func twoSquareMoves(from square: Square, in position: Position) -> [Square] {
        let initialRank = position.state.turn == .white ? 1 : 6
        guard square.rank == initialRank else {
            return []
        }
        
        let translation = position.state.turn == .white ? 1 : -1
        let isPathClear = (position.board.bitboards.white | position.board.bitboards.black) & square.translate(file: 0, rank: translation).bitboardMask == Int64.zero && (position.board.bitboards.white | position.board.bitboards.black) & square.translate(file: 0, rank: translation * 2).bitboardMask == Int64.zero
        guard isPathClear else {
            return []
        }
        
        return [square.translate(file: 0, rank: translation * 2)]
    }
    
    private func takingMoves(from square: Square, in position: Position) -> [Square] {
        let direction = position.state.turn == .white ? 1 : -1
        
        var destinations = [Square]()
        
        for translation in MovingTranslations.default.pawnTaking {
            let takingSquare = square.translate(file: translation.0, rank: translation.1 * direction)
            if !takingSquare.isValid {
                continue
            }
            if position.board.bitboards.bitboard(for: position.state.turn.negotiated) & takingSquare.bitboardMask != Int64.zero {
                destinations.append(takingSquare)
            }
        }
        
        return destinations
    }
    
    private func enPassantMoves(from square: Square, in position: Position) -> [Square] {
        guard let enPassantSquare = position.state.enPasant else {
            return []
        }
        
        let direction = position.state.turn == .white ? 1 : -1
        
        for takingTranslation in MovingTranslations.default.pawnTaking {
            let takingSquare = square.translate(file: takingTranslation.0, rank: takingTranslation.1 * direction)
            if takingSquare == enPassantSquare {
                return [enPassantSquare]
            }
        }
        
        return []
    }
    
    private func promotedMoves(from square: Square, in position: Position, destinations: [Square]) -> [Move] {
        let promotionRank = position.state.turn == .white ? 7 : 0
        let promotions = destinations.filter { $0.rank == promotionRank }
        let destinations = destinations.filter { $0.rank != promotionRank }

        var promotionMoves = promotions.flatMap {
            ["\(square)\($0)Q",
             "\(square)\($0)R",
             "\(square)\($0)B",
             "\(square)\($0)N"]
        }
        if position.state.turn == .black {
            promotionMoves = promotionMoves.map { $0.lowercased() }
        }

        return destinations.map { Move(from: square, to: $0) } + promotionMoves.map { Move(string: $0) }
    }
    
}
