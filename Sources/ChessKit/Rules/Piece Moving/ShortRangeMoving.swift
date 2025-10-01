//
//  ShortRangeMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev, 2020.
//  Modified by Alexander Perechnev, 2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import libchess

class ShortRangeMoving: RangeMoving {

    private let translations: [(Int, Int)]

    init(translations: [(Int, Int)]) {
        self.translations = translations
    }

    func coveredSquares(from square: Square, in position: Position) -> [Square] {
        var bitboards: bitboard_t = position.board.bitboards

        return self.translations
            .map { square.translate(file: $0.0, rank: $0.1) }
            .filter {
                $0.isValid
                    && bitboard_for_side(&bitboards, position.state.turn.side) & $0.bitboardMask
                        == 0
            }
    }

}
