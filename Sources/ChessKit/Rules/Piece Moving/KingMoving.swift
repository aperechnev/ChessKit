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
        let mask = position.board.bitboards.bitboard(for: position.state.turn.negotiated) & position.board.bitboards.king
        
        guard mask != Int64.zero else {
            return destinations
        }
        
        let square = Square(bitboardMask: mask)
        
        return destinations
            .filter { abs($0.file - square.file) > 1 || abs($0.rank - square.rank) > 1 }
    }
    
    private func castlingSquares(in position: Position) -> [Square] {
        let castlings = position.state.castlings.filter { $0.color == position.state.turn }
        
        var squares = [Square]()

        let rank = position.state.turn == .white ? 0 : 7
        
        let shouldBeEmpty: [PieceKind:[Int]] = [
            .king: [5, 6],
            .queen: [1, 2, 3]
        ]
        
        for castling in castlings {
            let isEmpty = shouldBeEmpty[castling.kind]!
                .map {
                    let square = Square(file: $0, rank: rank)
                    return (position.board.bitboards.white | position.board.bitboards.black) & square.bitboardMask == Int64.zero
                }
                .reduce(true) { $0 && $1 }
            
            if isEmpty {
                let file = castling.kind == .queen ? 2 : 6
                let square = Square(file: file, rank: rank)
                squares.append(square)
            }
        }
        
        return squares
    }
    
}
