//
//  KingMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class KingMoving: ShortRangeMoving {
    
    init() {
        super.init(translations: MovingTranslations.default.crossDiagonal)
    }
    
    override func moves(from square: Square, in position: Position) -> [String] {
        return super.destinations(from: square, in: position)
            .map { "\(square)\($0)" } +
            self.castlingMoves(in: position)
    }
    
    private func castlingMoves(in position: Position) -> [String] {
        var moves = [String]()
        
        if position.castlings.contains(Piece(kind: .king, color: position.turn)) {
            let rank = position.turn == .white ? "1" : "8"
            if position.board["f" + rank] == nil && position.board["g" + rank] == nil {
                moves.append("e" + rank + "g" + rank)
            }
        }
        if position.castlings.contains(Piece(kind: .queen, color: position.turn)) {
            let rank = position.turn == .white ? "1" : "8"
            if position.board["d" + rank] == nil && position.board["c" + rank] == nil && position.board["b" + rank] == nil {
                moves.append("e" + rank + "c" + rank)
            }
        }
        
        return moves
    }
    
}
