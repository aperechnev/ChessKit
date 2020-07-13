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
        let destinations = super.coveredSquares(from: square, in: position) + self.castlingSquares(in: position)
        return self.filterOppositeKingSquares(destinations: destinations, in: position)
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
        let castlings = position.castlings.filter { $0.color == position.turn }
        
        var squares = [Square]()

        let rank = position.turn == .white ? "1" : "8"
        
        let shouldBeEmpty: [PieceKind:[String]] = [
            .king: ["f", "g"],
            .queen: ["b", "c", "d"]
        ]
        
        for castling in castlings {
            let isEmpty = shouldBeEmpty[castling.kind]!
                .map { position.board[$0 + rank] == nil }
                .reduce(true) { $0 && $1 }
            
            if isEmpty {
                let file = castling.kind == .queen ? "c" : "g"
                let square = Square(coordinate: file + rank)
                squares.append(square)
            }
        }
        
        return squares
    }
    
}
