//
//  LongRangeMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class LongRangeMoving: RangeMoving {
    
    private let translations: [(Int, Int)]
    
    init(translations: [(Int, Int)]) {
        self.translations = translations
    }
    
    func coveredSquares(from square: Square, in position: Position) -> [Square] {
        self.translations
            .flatMap { self.process(translation: $0, for: square, in: position) }
    }
    
    private func process(translation: (Int, Int), for square: Square, in position: Position) -> [Square] {
        var destinations = [Square]()
        
        for offset in 1..<8 {
            let destination = square.translate(file: translation.0 * offset, rank: translation.1 * offset)
            if !destination.isValid {
                break
            }
            
            // If same color piece
            if position.board.bitboards.bitboard(for: position.state.turn) & destination.bitboardMask != UInt64.zero {
                break
            }
            // If opposite color piece
            if position.board.bitboards.bitboard(for: position.state.turn.negotiated) & destination.bitboardMask != UInt64.zero {
                destinations.append(destination)
                break
            }
            destinations.append(destination)
        }
        
        return destinations
    }
    
}
