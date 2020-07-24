//
//  Bitboards.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 21.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

typealias Bitboard = UInt64

struct Bitboards: Hashable {
    
    var white = Bitboard.zero
    var black = Bitboard.zero
    var king = Bitboard.zero
    var queen = Bitboard.zero
    var rook = Bitboard.zero
    var bishop = Bitboard.zero
    var knight = Bitboard.zero
    var pawn = Bitboard.zero
    
    func bitboard(for color: PieceColor) -> Bitboard {
        return color == .white ? white : black
    }
    
}
