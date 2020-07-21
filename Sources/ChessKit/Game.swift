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
    
    /// Number of occurrences of each position in game.
    public private(set) var positionsCounter: [Board:Int]
    /// List of moves made before current game position.
    public private(set) var movesHistory: [Move]
    
    /// Current game position.
    public var position: Position
    /// Indicates whether it's check in current position.
    public var isCheck: Bool {
        return self.rules.isCheck(in: self.position)
    }
    /// Indicates whether it's mate in current position.
    public var isMate: Bool {
        return self.rules.isMate(in: self.position)
    }
    
    // MARK: Initialization
    
    init(position: Position, moves: [Move], positionsCounter: [Board:Int]) {
        self.position = position
        self.movesHistory = moves
        self.positionsCounter = positionsCounter
        self.rules = StandardRules()
    }
    
    /**
     Initialize game with given position.
     
     - Parameters:
        - position: Initial game position.
        - moves: List of moves before given position.
    */
    public init(position: Position, moves: [Move] = []) {
        self.positionsCounter = [
            position.board: 1
        ]
        self.movesHistory = moves
        self.position = position
        self.rules = StandardRules()
    }
    
    /**
     Initialize game with given position and rules.
     
     - Parameters:
        - position: Initial game position.
        - moves: List of moves before given position.
        - rules: Game rules.
     */
    internal init(position: Position, moves: [Move] = [], rules: Rules) {
        self.positionsCounter = [
            position.board: 1
        ]
        self.movesHistory = moves
        self.position = position
        self.rules = rules
    }
    
    // MARK: Making moves
    
    /// List of legal moves in current game position.
    public var legalMoves: [Move] {
        return self.rules.legalMoves(in: self.position)
    }
    
    /**
     Make move.
     
     - Parameters:
        - move: A move in a long algebraic notation (e.g., `"e2e4"`, `"g1f3"`, `"e7e8Q"`).
     */
    public func make(move stringMove: String) {
        let move = Move(string: stringMove)
        self.make(move: move)
    }
    
    /**
    Make move.
    
    - Parameters:
       - move: A move to make.
    */
    public func make(move: Move) {
        self.movesHistory.append(move)
        
        let enPassant = self.updateEnPassant(for: move)
        
        self.updateCounters(for: move)
        self.updateCastlings(for: move)
        self.perform(move: move)
        
        self.position.state.enPasant = enPassant
        self.toogleTurn()
        
        if self.positionsCounter[self.position.board] == nil {
            self.positionsCounter[self.position.board] = 0
        }
        self.positionsCounter[self.position.board]! += 1
    }
    
    private func perform(move: Move) {
        let isCastling = position.board.bitboards.king & move.from.bitboardMask != Int64.zero &&
            abs(move.from.file - move.to.file) > 1
        
        let isEnPassant = position.board.bitboards.pawn & move.from.bitboardMask != Int64.zero &&
            move.to == self.position.state.enPasant
        
        let isPawnPromotion = move.promotion != nil
        
        if isCastling {
            self.performCastling(move: move)
        } else if isEnPassant {
            self.performEnPassant(move: move)
        } else if isPawnPromotion {
            self.performPawnPromotion(move: move)
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
    
    private func performPawnPromotion(move: Move) {
        self.performSimple(move: move)
        
        guard let kind = move.promotion else {
            return
        }
        self.position.board[move.to] = Piece(kind: kind, color: self.position.state.turn)
    }
    
    private func updateCounters(for move: Move) {
        let isTaking = position.board.bitboards.bitboard(for: position.state.turn.negotiated) & move.to.bitboardMask != Int64.zero
        let isPawnAdvance = position.board.bitboards.pawn & move.from.bitboardMask != Int64.zero
        
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
        if position.board.bitboards.pawn & move.from.bitboardMask == Int64.zero {
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
    
    // MARK: Utilities
    
    /**
     Creates a deep copy of current game.
     
     - Returns: New `Game` object.
     */
    public func deepCopy() -> Game {
        let position = self.position
        let moves = self.movesHistory.map { $0 }
        
        return Game(
            position: position,
            moves: moves,
            positionsCounter: self.positionsCounter
        )
    }
    
}
