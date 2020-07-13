//
//  StandardRules.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

public class StandardRules: Rules {
    
    private let crossTranlations = [
        (-1, 0), (0, 1), (1, 0), (0, -1)
    ]
    private let diagonalTranlations = [
        (-1, -1), (1, 1), (-1, 1), (1, -1)
    ]
    private let knightTranslations = [
        (-2, 1), (-1, 2), (1, 2), (2, 1), (2, -1), (1, -2), (-1, -2), (-2, -1)
    ]
    private let pawnTakingTranslations = [
        (-1, 1), (1, 1)
    ]
    
    public func movesForPiece(at square: Square, in position: Position) -> [String] {
        guard let piece = position.board[square] else {
            return []
        }
        guard piece.color == position.turn else {
            return []
        }
        
        switch piece.kind {
        case .king:
            return self.kingMoves(at: square, in: position)
        case .queen:
            return self.queenMoves(at: square, in: position)
        case .rook:
            return self.rookMoves(at: square, in: position)
        case .bishop:
            return self.bishopMoves(at: square, in: position)
        case .knight:
            return self.knightMoves(at: square, in: position)
        case .pawn:
            return self.pawnMoves(at: square, in: position)
        }
    }
    
    private func kingMoves(at square: Square, in position: Position) -> [String] {
        return (self.crossTranlations + self.diagonalTranlations)
            .map { square.translate(file: $0.0, rank: $0.1) }
            .filter { $0.isValid }
            .filter { position.board[$0]?.color != position.turn }
            .map { "\(square)\($0)" }
    }
    
    private func queenMoves(at square: Square, in position: Position) -> [String] {
        let translations = self.crossTranlations + self.diagonalTranlations
        return self.longRangeMoves(at: square, in: position, translations: translations)
    }
    
    private func rookMoves(at square: Square, in position: Position) -> [String] {
        return self.longRangeMoves(at: square, in: position, translations: self.crossTranlations)
    }
    
    private func bishopMoves(at square: Square, in position: Position) -> [String] {
        return self.longRangeMoves(at: square, in: position, translations: self.diagonalTranlations)
    }
    
    private func knightMoves(at square: Square, in position: Position) -> [String] {
        return self.knightTranslations
            .map { square.translate(file: $0.0, rank: $0.1) }
            .filter { $0.isValid }
            .filter { position.board[$0]?.color != position.turn }
            .map { "\(square)\($0)" }
    }
    
    private func pawnMoves(at square: Square, in position: Position) -> [String] {
        let direction = position.turn == .white ? 1 : -1
        
        var destinations = [Square]()
        
        // One-square move
        let oneSquareDestination = square.translate(file: 0, rank: direction)
        if oneSquareDestination.isValid {
            if position.board[oneSquareDestination] == nil {
                destinations.append(oneSquareDestination)
            }
        }
        
        // Two-square moves
        if position.turn == .white && square.rank == 1 {
            destinations.append(square.translate(file: 0, rank: 2))
        }
        if position.turn == .black && square.rank == 6 {
            destinations.append(square.translate(file: 0, rank: -2))
        }
        
        // Piece taking
        for translation in self.pawnTakingTranslations {
            let takingSquare = square.translate(file: translation.0, rank: translation.1 * direction)
            if !takingSquare.isValid {
                continue
            }
            if position.board[takingSquare]?.color.negotiated == position.turn {
                destinations.append(takingSquare)
            }
        }
        
        // En passant
        if let enPasantSquare = position.enPasant {
            for takingTranslation in self.pawnTakingTranslations {
                if square.translate(file: takingTranslation.0, rank: takingTranslation.1 * direction) == enPasantSquare {
                    destinations.append(enPasantSquare)
                }
            }
        }
        
        // Promotion
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
    
    private func longRangeMoves(at square: Square,
                                in position: Position,
                                translations: [(Int, Int)]) -> [String] {
        var destinations = [String]()
        
        for translation in translations {
            for offset in 1..<8 {
                let destination = square.translate(file: translation.0 * offset, rank: translation.1 * offset)
                if !destination.isValid {
                    break
                }
                
                if position.board[destination]?.color == position.turn {
                    break
                }
                if position.board[destination]?.color != nil && position.board[destination]?.color != position.turn {
                    destinations.append("\(destination)")
                    break
                }
                destinations.append("\(destination)")
            }
        }
        
        return destinations.map { "\(square)\($0)" }
    }
    
}
