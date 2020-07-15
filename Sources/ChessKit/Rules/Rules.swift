//
//  Rules.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

protocol Rules {
    func movesForPiece(at square: Square, in position: Position) -> [Move]
    func legalMoves(in position: Position) -> [Move]
    func isCheck(in position: Position) -> Bool
    func isMate(in position: Position) -> Bool
}
