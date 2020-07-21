//
//  ShortRangeMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class ShortRangeMoving: RangeMoving {
    
    private let translations: [(Int, Int)]
    
    init(translations: [(Int, Int)]) {
        self.translations = translations
    }
    
    func coveredSquares(from square: Square, in position: Position) -> [Square] {
        return self.translations
            .map { square.translate(file: $0.0, rank: $0.1) }
            .filter { $0.isValid && position.board.bitboards.bitboard(for: position.state.turn) & $0.bitboardMask == 0 }
    }
    
}
