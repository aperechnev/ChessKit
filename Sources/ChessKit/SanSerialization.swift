//
//  SanSerialization.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 01.03.2021.
//

import Foundation

public class SanSerialization {
    
    private let kCastlingKing = "O-O"
    private let kCastlingQueen = "O-O-O"
    
    /// `SanSerialization` object with default settings.
    public static let `default` = SanSerialization()
    
    public func san(for move: Move, in game: Game) -> String {
        guard let sourceSquare = game.position.board[move.from] else {
            return ""
        }
        let targetSquare = game.position.board[move.to]
        
        if sourceSquare.kind == .pawn {
            var san = targetSquare?.kind != nil ? "\(move.from.coordinate.first!)x\(move.to)" : move.to.coordinate
            let gameCopy = game.deepCopy()
            gameCopy.make(move: move)
            if gameCopy.isCheck {
                san += "+"
            }
            return san
        } else {
            if sourceSquare.kind == .king {
                if move.from.file == 4 {
                    var san = ""
                    
                    if move.to.file == 6 {
                        san = "O-O"
                    } else if move.to.file == 2 {
                        san = "O-O-O"
                    }
                    
                    let gameCopy = game.deepCopy()
                    gameCopy.make(move: move)
                    if gameCopy.isCheck {
                        san += "+"
                    }
                    
                    return san
                }
            }
            
            var san = sourceSquare.kind.description.uppercased()
            
            let candidates = game.legalMoves
                .filter { $0.to == move.to && $0 != move }
                .filter { game.position.board[$0.from]?.kind == sourceSquare.kind }
            
            if !candidates.filter({ $0.from.file == move.from.file }).isEmpty {
                san.append(move.from.coordinate.last!)
            }
            if !candidates.filter({ $0.from.rank == move.from.rank }).isEmpty {
                san.append(move.from.coordinate.first!)
            }
            
            if targetSquare != nil {
                san.append("x")
            }
            
            san.append(move.to.coordinate)
            
            let gameCopy = game.deepCopy()
            gameCopy.make(move: move)
            if gameCopy.isCheck {
                san += "+"
            }
            
            return san
        }
    }
    
    public func move(for san: String, in game: Game) -> Move {
        let san = san.replacingOccurrences(of: "+", with: "")
        
        if [kCastlingKing, kCastlingQueen].contains(san) {
            let file = san == kCastlingKing ? "g" : "c"
            let rank = game.position.state.turn == .white ? "1" : "8"
            return Move(string: "e\(rank)\(file)\(rank)")
        } else if san.count == 2 {
            let candidates = game.legalMoves
                .filter { $0.to == Square(coordinate: san) }
                .filter { game.position.board[$0.from]?.kind == .pawn }
            return candidates.first!
        } else {
            var move = "", s = san.replacingOccurrences(of: "x", with: "")
            
            move += "\(s.popLast()!)"
            move = "\(s.popLast()!)" + move
            
            let pieceKind = PieceKind(rawValue: "\(s.lowercased().first!)")
            if pieceKind == nil {
                return game.legalMoves
                    .filter({ $0.to.description == move })
                    .filter({ game.position.board[$0.from]?.kind == .pawn })
                    .first!
            }
            
            s = "\(s.dropFirst())"
            
            var candidates = game.legalMoves
                .filter { game.position.board[$0.from]?.kind == pieceKind }
                .filter { $0.to.description == move }
            
            if !s.isEmpty {
                candidates = candidates
                    .filter { $0.from.description.contains(s) }
            }
            
            move = candidates.first!.from.description + move
            
            return Move(string: move)
        }
    }
    
}
