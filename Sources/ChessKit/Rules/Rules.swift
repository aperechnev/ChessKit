//
//  Rules.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

public protocol Rules {
    func movesForPiece(at square: Square, in position: Position) -> [String]
    func legalMoves(in position: Position) -> [String]
}
