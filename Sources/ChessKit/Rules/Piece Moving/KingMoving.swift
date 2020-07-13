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
    
    override func coveredSquares(from square: Square, in position: Position) -> [Square] {
        var destinations = super.coveredSquares(from: square, in: position)
        destinations = self.filterOppositeKingSquares(destinations: destinations, in: position)
        return destinations + self.castlingSquares(in: position)
    }
    
    private func filterOppositeKingSquares(destinations: [Square], in position: Position) -> [Square] {
        guard let (square, _) = position.board.enumeratedPieces()
            .filter({ $1 == Piece(kind: .king, color: position.turn.negotiated) })
            .first else {
                return destinations
        }
        
        return destinations
            .filter { abs($0.file - square.file) > 1 || abs($0.rank - square.rank) > 1 }
    }
    
    private func castlingSquares(in position: Position) -> [Square] {
        var squares = [Square]()
        
        if position.castlings.contains(Piece(kind: .king, color: position.turn)) {
            let rank = position.turn == .white ? "1" : "8"
            if position.board["f" + rank] == nil && position.board["g" + rank] == nil {
                squares.append(Square(coordinate: "g" + rank))
            }
        }
        if position.castlings.contains(Piece(kind: .queen, color: position.turn)) {
            let rank = position.turn == .white ? "1" : "8"
            if position.board["d" + rank] == nil && position.board["c" + rank] == nil && position.board["b" + rank] == nil {
                squares.append(Square(coordinate: "c" + rank))
            }
        }
        
        return squares
    }
    
}
