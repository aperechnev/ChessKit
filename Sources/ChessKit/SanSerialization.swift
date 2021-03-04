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
    
    // MARK: - Serialization
    
    public func san(for move: Move, in game: Game) -> String {
        guard let sourceSquare = game.position.board[move.from] else {
            return ""
        }
        let targetSquare = game.position.board[move.to]
        
        if sourceSquare.kind == .pawn {
            var san = targetSquare?.kind != nil ? "\(move.from.coordinate.first!)x\(move.to)" : move.to.coordinate
            if let promotion = move.promotion {
                san += "=\(promotion)".uppercased()
            }
            return self.appendCheck(to: san, with: move, in: game)
        } else {
            if sourceSquare.kind == .king {
                if move.from.file == 4 {
                    var san = ""
                    
                    if move.to.file == 6 {
                        san = "O-O"
                    } else if move.to.file == 2 {
                        san = "O-O-O"
                    }
                    
                    return self.appendCheck(to: san, with: move, in: game)
                }
            }
            
            var san = sourceSquare.kind.description.uppercased()
            
            let candidates = game.legalMoves
                .filter { $0.to == move.to && $0 != move }
                .filter { game.position.board[$0.from]?.kind == sourceSquare.kind }
            
            if !candidates.filter({ $0.from.file == move.from.file }).isEmpty {
                san.append(move.from.coordinate.last!)
            } else if !candidates.filter({ $0.from.rank == move.from.rank }).isEmpty {
                san.append(move.from.coordinate.first!)
            } else if !candidates.isEmpty {
                san.append(move.from.coordinate.first!)
            }
            
            if targetSquare != nil {
                san.append("x")
            }
            
            san.append(move.to.coordinate)
            
            return self.appendCheck(to: san, with: move, in: game)
        }
    }
    
    private func appendCheck(to san: String, with move: Move, in game: Game) -> String {
        let gameCopy = game.deepCopy()
        gameCopy.make(move: move)
        if gameCopy.isMate {
            return san + "#"
        } else if gameCopy.isCheck {
            return san + "+"
        }
        return san
    }
    
    // MARK: - Deserialization
    
    public func move(for san: String, in game: Game) -> Move {
        let promotionRange = san.range(of: "=[QRBN]", options: .regularExpression)
        
        var promotion: PieceKind? = nil
        if let range = promotionRange {
            promotion = PieceKind(rawValue: san[range].replacingOccurrences(of: "=", with: "").lowercased())
        }
        
        let san = san
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "=[QRBN]", with: "", options: .regularExpression)
        
        if [kCastlingKing, kCastlingQueen].contains(san) {
            let file = san == kCastlingKing ? "g" : "c"
            let rank = game.position.state.turn == .white ? "1" : "8"
            return Move(string: "e\(rank)\(file)\(rank)")
        } else if san.count == 2 {
            let move = game.legalMoves
                .filter { $0.to == Square(coordinate: san) }
                .filter { game.position.board[$0.from]?.kind == .pawn }
                .first!
            return Move(from: move.from, to: move.to, promotion: promotion)
        } else {
            var move = "", s = san.replacingOccurrences(of: "x", with: "")
            
            move += "\(s.popLast()!)"
            move = "\(s.popLast()!)" + move
            
            var pieceKind: PieceKind? = nil
            if s.first!.isUppercase {
                pieceKind = PieceKind(rawValue: "\(s.lowercased().first!)")
            }
            
            if pieceKind == nil {
                let move = game.legalMoves
                    .filter({ $0.to.description == move })
                    .filter({ game.position.board[$0.from]?.kind == .pawn })
                    .filter({ $0.from.description.contains(s) })
                    .first!
                return Move(from: move.from, to: move.to, promotion: promotion)
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
