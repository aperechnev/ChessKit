//
//  RangeMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

protocol RangeMoving: PieceMoving {
    
}

extension RangeMoving {
    
    func moves(from square: Square, in position: Position) -> [Move] {
        return self.coveredSquares(from: square, in: position)
            .map { Move(from: square, to: $0) }
    }
    
}
