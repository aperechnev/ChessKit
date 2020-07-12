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
        var destinations = [Square]()
        return destinations.map { "\(square)\($0)" }
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
