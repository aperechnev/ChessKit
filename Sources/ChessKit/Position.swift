//
//  Position.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Game position.
public struct Position: Hashable {
    
    /// Position state.
    public struct State: Hashable {
        /// Color that holds current side that should make the next move.
        public var turn: PieceColor
        /// Available castlings in position.
        public var castlings: [Piece]
        /// The square where pawn may be taken by en-passant move.
        public var enPasant: Square?
        
    }
    
    /// Position counter.
    public struct Counter: Hashable {
        /**
         This is the number of halfmoves since the last capture or pawn advance.
         
         This is used to determine if a draw can be claimed under the fifty-move rule.
         */
        public var halfMoves: Int
        /**
         The number of the full move.
         
         It starts at 1, and is incremented after Black's move.
         */
        public var fullMoves: Int
    }
    
    /// Board with pieces that represents current position.
    public var board: Board
    /// Position state.
    public var state: State
    /// Position counters.
    public var counter: Counter
    
}
