//
//  PieceMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

protocol PieceMoving {
    func moves(from square: Square, in position: Position) -> [Move]
    func coveredSquares(from square: Square, in position: Position) -> [Square]
}
