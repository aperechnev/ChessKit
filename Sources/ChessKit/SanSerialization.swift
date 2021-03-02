//
//  SanSerialization.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 01.03.2021.
//

import Foundation

public class SanSerialization {
    
    /// `SanSerialization` object with default settings.
    public static let `default` = SanSerialization()
    
    public func san(for move: Move, in game: Game) -> String {
        guard let sourceSquare = game.position.board[move.from] else {
            return ""
        }
        let targetSquare = game.position.board[move.to]
        
        if sourceSquare.kind == .pawn {
            if targetSquare?.kind == .pawn {
                return "\(move.from.coordinate.first!)x\(move.to.coordinate.first!)"
            } else if targetSquare != nil {
                return "\(move.from.coordinate.first!)x\(move.to)"
            }
            return move.to.coordinate
        } else {
            if sourceSquare.kind == .king {
                if move.from.file == 4 {
                    if move.to.file == 6 {
                        return "O-O"
                    } else if move.to.file == 2 {
                        return "O-O-O"
                    }
                }
            }
            
            var san = sourceSquare.kind.description.uppercased()
            
            let candidates = game.legalMoves.filter { $0.to == move.to && $0 != move }
            
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
            
            return san
        }
    }
    
    public func move(for san: String, in game: Game) -> Move {
        if san == "O-O" {
            if game.position.state.turn == .white {
                return Move(string: "e1g1")
            } else {
                return Move(string: "e8g8")
            }
        } else if san == "O-O-O" {
            if game.position.state.turn == .white {
                return Move(string: "e1c1")
            } else {
                return Move(string: "e8c8")
            }
        } else if san.count == 2 {
            let candidates = game.legalMoves
                .filter { $0.to == Square(coordinate: san) }
                .filter { game.position.board[$0.from]?.kind == .pawn }
            return candidates.first!
        } else if san.count == 3 &&  san.range(of: "[a-z]x[a-z]", options: .regularExpression, range: nil, locale: nil) != nil {
            return game.legalMoves
                .filter { game.position.board[$0.from]?.kind == .pawn }
                .filter { $0.from.description.first == san.first }
                .filter { $0.to.description.first == san.last }
                .first!
        } else {
            var move = "", s = san.replacingOccurrences(of: "x", with: "")
            
            move += "\(s.popLast()!)"
            move = "\(s.popLast()!)" + move
            
            let pieceKind = PieceKind(rawValue: "\(s.lowercased().first!)")
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
