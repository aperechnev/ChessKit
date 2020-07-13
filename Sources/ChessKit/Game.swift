//
//  Game.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Chess game.
public class Game {
    
    private let rules: Rules
    
    /// Current game position.
    public var position: Position
    
    // MARK: Initialization
    
    /**
    Initialize game with given position.
    
    - Parameters:
       - position: Initial game position.
    */
    public init(position: Position) {
        self.position = position
        self.rules = StandardRules()
    }
    
    /**
     Initialize game with given position and rules.
     
     - Parameters:
        - position: Initial game position.
        - rules: Game rules.
     */
    internal init(position: Position, rules: Rules) {
        self.position = position
        self.rules = rules
    }
    
    // MARK: Making moves
    
    /**
     Make move.
     
     - Parameters:
        - move: A move in a long algebraic notation (e.g., `"e2e4"`, `"g1f3"`, `"e7e8Q"`).
     */
    public func make(move stringMove: String) {
        let move = Move(string: stringMove)
        let enPassant = self.updateEnPassant(for: move)
        
        self.updateCounters(for: move)
        self.updateCastlings(for: move)
        self.perform(move: move)
        
        self.position.state.enPasant = enPassant
        self.toogleTurn()
    }
    
    private func perform(move: Move) {
        let isCastling = self.position.board[move.from]?.kind == .king &&
            abs(move.from.file - move.to.file) > 1
        
        let isEnPassant = self.position.board[move.from]?.kind == .pawn &&
            move.to.file == self.position.state.enPasant?.file
        
        if isCastling {
            self.performCastling(move: move)
        } else if isEnPassant {
            self.performEnPassant(move: move)
        } else {
            self.performSimple(move: move)
        }
    }
    
    private func performSimple(move: Move) {
        self.position.board[move.to] = self.position.board[move.from]
        self.position.board[move.from] = nil
    }
    
    private func performCastling(move: Move) {
        self.performSimple(move: move)
        
        let rank = self.position.state.turn == .white ? "1" : "8"
        
        if move.to.file == 2 { // Queen side
            self.performSimple(move: Move(string: "a" + rank + "d" + rank))
        } else if move.to.file == 6 { // King side
            self.performSimple(move: Move(string: "h" + rank + "f" + rank))
        }
    }
    
    private func performEnPassant(move: Move) {
        self.performSimple(move: move)
        
        guard let enPassant = self.position.state.enPasant else {
            return
        }
        
        let rank = self.position.state.turn == .white ? 4 : 3
        self.position.board[Square(file: enPassant.file, rank: rank)] = nil
    }
    
    private func updateCounters(for move: Move) {
        let isTaking = self.position.board[move.to] != nil
        let isPawnAdvance = self.position.board[move.from]?.kind == .pawn
        
        if isTaking || isPawnAdvance {
            self.position.counter.halfMoves = 0
        } else {
            self.position.counter.halfMoves += 1
        }
        
        if self.position.state.turn == .black {
            self.position.counter.fullMoves += 1
        }
    }
    
    private func toogleTurn() {
        self.position.state.turn = self.position.state.turn.negotiated
    }
    
    private func updateEnPassant(for move: Move) -> Square? {
        guard let piece = self.position.board[move.from] else {
            return nil
        }
        guard piece.kind == .pawn else {
            return nil
        }
        guard abs(move.from.rank - move.to.rank) == 2 else {
            return nil
        }
        
        let rank = self.position.state.turn == .white ? 2 : 5
        return Square(file: move.from.file, rank: rank)
    }
    
    private func updateCastlings(for move: Move) {
        guard let piece = self.position.board[move.from] else {
            return
        }
        
        if piece.kind == .king {
            self.position.state.castlings = self.position.state.castlings
                .filter { $0.color != self.position.state.turn }
        }
        
        if piece.kind == .rook {
            let kind: PieceKind = move.from.file == 0 ? .queen : .king
            
            self.position.state.castlings = self.position.state.castlings
                .filter { $0.color != self.position.state.turn || $0.kind != kind }
        }
    }
    
}
