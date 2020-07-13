//
//  KingMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class KingMoving: PieceMoving {
    
    private let translations = [
        (-1, 0), (0, 1), (1, 0), (0, -1), (-1, -1), (1, 1), (-1, 1), (1, -1)
    ]
    
    func moves(from square: Square, in position: Position) -> [String] {
        return self.translations
            .map { square.translate(file: $0.0, rank: $0.1) }
            .filter { $0.isValid }
            .filter { position.board[$0]?.color != position.turn }
            .map { "\(square)\($0)" }
    }
    
}
