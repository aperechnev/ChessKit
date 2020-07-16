//
//  FenSerialization.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

public class FenSerialization {
    
    /// `FenSerialization` object with default settings.
    public static let `default` = FenSerialization()
    
    /**
     Deserialize position from given FEN string.
     
     - Parameters:
        - fen: String containing FEN position.
     
     - Returns: `Position` object initialized from given FEN string.
     */
    public func deserialize(fen: String) -> Position {
        let parts = fen.split(separator: " ")
        
        let state = Position.State(turn: self.turn(from: parts[1]),
                                   castlings: self.castlings(from: parts[2]),
                                   enPasant: self.enPasant(from: parts[3]))
        
        let counter = Position.Counter(halfMoves: self.movesCount(from: parts[4]),
                                       fullMoves: self.movesCount(from: parts[5]))
        
        return Position(board: self.board(from: parts[0]),
                        state: state,
                        counter: counter)
    }
    
    /**
     Serialize position to FEN string.
     
     - Parameters:
        - position: `Position` object that sould be serialized.
     
     - Returns: FEN string describing given position.
     */
    public func serialize(position: Position) -> String {
        let board = self.fen(from: position.board)
        let turn = position.state.turn == .white ? "w" : "b"
        
        var castling = position.state.castlings
            .map { "\($0)" }
            .reduce("") { $0 + $1 }
        if castling == "" {
            castling = "-"
        }
        
        let enPasant = position.state.enPasant != nil ? "\(position.state.enPasant!)" : "-"
        
        let halfmove = "\(position.counter.halfMoves)"
        let fullmove = "\(position.counter.fullMoves)"
        
        return [board, turn, castling, enPasant, halfmove, fullmove]
            .joined(separator: " ")
    }
    
    // MARK: Serialization
    
    private func fen(from board: Board) -> String {
        var lines: [String] = []
        
        for rank in (0...7).reversed() {
            var empty = 0
            var line = ""
            
            for file in 0...7 {
                let square = Square(file: file, rank: rank)
                
                if let piece = board[square] {
                    if empty > 0 {
                        line += "\(empty)"
                        empty = 0
                    }
                    line += "\(piece)"
                } else {
                    empty += 1
                }
            }
            
            if empty > 0 {
                line += "\(empty)"
                empty = 0
            }
            
            lines.append(line)
        }
        
        return lines.joined(separator: "/")
    }
    
    // MARK: Deserialization
    
    private func board(from sequence: String.SubSequence) -> Board {
        var board = Board()
        var square = Square(file: 0, rank: 7)
        
        for c in sequence {
            if let piece = Piece(character: c)  {
                board[square] = piece
                square = square.translate(file: 1, rank: 0)
            } else if c == "/" {
                square = Square(file: 0, rank: square.rank - 1)
            } else if let n = c.wholeNumberValue {
                square = square.translate(file: n, rank: 0)
            } else {
                preconditionFailure("Can't parse board position from FEN string.")
            }
        }
        
        return board
    }
    
    private func turn(from sequence: String.SubSequence) -> PieceColor {
        return sequence.lowercased() == "b" ? .black : .white
    }
    
    private func castlings(from sequence: String.SubSequence) -> [Piece] {
        if sequence == "-" {
            return []
        }
        return sequence.map { Piece(character: $0)! }
    }
    
    private func enPasant(from sequence: String.SubSequence) -> Square? {
        return sequence == "-" ? nil : Square(coordinate: String(sequence))
    }
    
    private func movesCount(from sequence: String.SubSequence) -> Int {
        guard let count = Int(String(sequence)) else {
            preconditionFailure("Can't parse moves count from sequence.")
        }
        return count
    }
    
}
