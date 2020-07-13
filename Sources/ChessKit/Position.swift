//
//  Position.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

public struct Position {
    
    public struct State {
        public var turn: PieceColor
        public var castlings: [Piece]
        public var enPasant: Square?
    }
    
    public struct Counter {
        public var halfMoves: Int
        public var fullMoves: Int
    }
    
    public var board: Board
    public var state: State
    public var counter: Counter
    
    func deepCopy() -> Position {
        return Position(board: self.board.deepCopy(),
                        state: self.state,
                        counter: self.counter)
    }
    
}
