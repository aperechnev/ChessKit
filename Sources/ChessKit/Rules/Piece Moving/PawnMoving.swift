//
//  PawnMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class PawnMoving: PieceMoving {
    
    func moves(from square: Square, in position: Position) -> [String] {
        var destinations: [Square] = self.oneSquareMoves(from: square, in: position) +
            self.twoSquareMoves(from: square, in: position) +
            self.takingMoves(from: square, in: position) +
            self.enPassantMoves(from: square, in: position)
        
        // Promotions
        let promotionRank = position.turn == .white ? 7 : 0
        let promotions = destinations.filter { $0.rank == promotionRank }
        destinations = destinations.filter { $0.rank != promotionRank }
        var promotionMoves = promotions.flatMap {
            ["\(square)\($0)Q",
             "\(square)\($0)R",
             "\(square)\($0)B",
             "\(square)\($0)N"]
        }
        if position.turn == .black {
            promotionMoves = promotionMoves.map { $0.lowercased() }
        }
        
        return destinations.map { "\(square)\($0)" } + promotionMoves
    }
    
    private func oneSquareMoves(from square: Square, in position: Position) -> [Square] {
        let direction = position.turn == .white ? 1 : -1
        let destination = square.translate(file: 0, rank: direction)
        if destination.isValid {
            if position.board[destination] == nil {
                return [destination]
            }
        }
        return []
    }
    
    private func twoSquareMoves(from square: Square, in position: Position) -> [Square] {
        let initialRank = position.turn == .white ? 1 : 6
        guard square.rank == initialRank else {
            return []
        }
        
        let translation = position.turn == .white ? 1 : -1
        let isPathClear = position.board[square.translate(file: 0, rank: translation)] == nil &&
            position.board[square.translate(file: 0, rank: translation * 2)] == nil
        guard isPathClear else {
            return []
        }
        
        return [square.translate(file: 0, rank: translation * 2)]
    }
    
    private func takingMoves(from square: Square, in position: Position) -> [Square] {
        let direction = position.turn == .white ? 1 : -1
        
        var destinations = [Square]()
        
        for translation in MovingTranslations.default.pawnTaking {
            let takingSquare = square.translate(file: translation.0, rank: translation.1 * direction)
            if !takingSquare.isValid {
                continue
            }
            if position.board[takingSquare]?.color.negotiated == position.turn {
                destinations.append(takingSquare)
            }
        }
        
        return destinations
    }
    
    private func enPassantMoves(from square: Square, in position: Position) -> [Square] {
        guard let enPassantSquare = position.enPasant else {
            return []
        }
        
        let direction = position.turn == .white ? 1 : -1
        
        for takingTranslation in MovingTranslations.default.pawnTaking {
            let takingSquare = square.translate(file: takingTranslation.0, rank: takingTranslation.1 * direction)
            if takingSquare == enPassantSquare {
                return [enPassantSquare]
            }
        }
        
        return []
    }
    
}
