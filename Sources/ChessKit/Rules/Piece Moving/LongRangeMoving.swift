//
//  LongRangeMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class LongRangeMoving: PieceMoving {
    
    private let translations: [(Int, Int)]
    
    init(translations: [(Int, Int)]) {
        self.translations = translations
    }
    
    func moves(from square: Square, in position: Position) -> [Move] {
        return self.coveredSquares(from: square, in: position)
            .map { Move(from: square, to: $0) }
    }
    
    func coveredSquares(from square: Square, in position: Position) -> [Square] {
        self.translations
            .flatMap { self.process(translation: $0, for: square, in: position) }
            .map { Square(coordinate: $0) }
    }
    
    private func process(translation: (Int, Int), for square: Square, in position: Position) -> [String] {
        var destinations = [String]()
        
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
        
        return destinations
    }
    
}
