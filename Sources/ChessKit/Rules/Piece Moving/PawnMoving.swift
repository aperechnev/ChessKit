//
//  PawnMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class PawnMoving: PieceMoving {
    
    func moves(from square: Square, in position: Position) -> [String] {
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
        for translation in MovingTranslations.default.pawnTaking {
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
            for takingTranslation in MovingTranslations.default.pawnTaking {
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
    
}
