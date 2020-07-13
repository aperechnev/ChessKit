//
//  Position.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

public struct Position {
    
    public var board: Board
    public var turn: PieceColor
    public var castlings: [Piece]
    public var enPasant: Square?
    public var halfMovesCount: Int
    public var fullMovesCount: Int
    
    func deepCopy() -> Position {
        return Position(board: self.board.deepCopy(),
                        turn: self.turn,
                        castlings: self.castlings,
                        enPasant: self.enPasant,
                        halfMovesCount: self.halfMovesCount,
                        fullMovesCount: self.fullMovesCount)
    }
    
}
