//
//  ShortRangeMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class ShortRangeMoving: PieceMoving {
    
    private let translations: [(Int, Int)]
    
    init(translations: [(Int, Int)]) {
        self.translations = translations
    }
    
    func moves(from square: Square, in position: Position) -> [String] {
        return self.translations
            .map { square.translate(file: $0.0, rank: $0.1) }
            .filter { $0.isValid }
            .filter { position.board[$0]?.color != position.turn }
            .map { "\(square)\($0)" }
    }
    
}
