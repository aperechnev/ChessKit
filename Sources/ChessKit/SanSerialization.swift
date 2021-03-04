//
//  SanSerialization.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 01.03.2021.
//

import Foundation

/// SAN moves serialization and deserialization.
public class SanSerialization {
    
    private let kCastlingKing = "O-O"
    private let kCastlingQueen = "O-O-O"
    
    /// `SanSerialization` object with default settings.
    public static let `default` = SanSerialization()
    
    // MARK: - Serialization
    
    /**
     Serialize move to SAN string.
     
     - Parameters:
        - move: `Move` object that sould be serialized.
        - game: A game which is about to make a given move.
     
     - Returns: SAN string describing given move.
     */
    public func san(for move: Move, in game: Game) -> String {
        switch game.position.board[move.from]?.kind {
        case .none:
            return ""
        case .pawn:
            return self.processPawn(move: move, in: game)
        case .king:
            return self.processKing(move: move, in: game)
        default:
            return self.processPiece(move: move, in: game)
        }
    }
    
    private func processPawn(move: Move, in game: Game) -> String {
        let targetSquare = game.position.board[move.to]
        var san = targetSquare?.kind != nil ? "\(move.from.coordinate.first!)x\(move.to)" : move.to.coordinate
        if let promotion = move.promotion {
            san += "=\(promotion)".uppercased()
        }
        return self.appendCheck(to: san, with: move, in: game)
    }
    
    private func processKing(move: Move, in game: Game) -> String {
        if move.from.file == 4 {
            if move.to.file == 6 {
                return self.appendCheck(to: "O-O", with: move, in: game)
            } else if move.to.file == 2 {
                return self.appendCheck(to: "O-O-O", with: move, in: game)
            }
        }
        return self.processPiece(move: move, in: game)
    }
    
    private func processPiece(move: Move, in game: Game) -> String {
        let sourceSquare = game.position.board[move.from]!
        let targetSquare = game.position.board[move.to]
        
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
    
    /**
     Deserialize move from given SAN string.
     
     - Parameters:
        - san: String containing SAN move.
        - game: A game which is about to make a given SAN move.
     
     - Returns: `Move` object initialized from given SAN string.
     */
    public func move(for san: String, in game: Game) -> Move {
        let promotion = self.promotion(in: san)
        
        let san = san
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "#", with: "")
            .replacingOccurrences(of: "=[QRBN]", with: "", options: .regularExpression)
        
        if [kCastlingKing, kCastlingQueen].contains(san) {
            return self.processCastling(san: san, in: game)
        } else if san.count == 2 {
            return self.processPawn(san: san, promotion: promotion, in: game)
        } else {
            return self.process(san: san, promotion: promotion, in: game)
        }
    }
    
    private func promotion(in san: String) -> PieceKind? {
        if let range = san.range(of: "=[QRBN]", options: .regularExpression) {
            let piece = san[range]
                .replacingOccurrences(of: "=", with: "")
                .lowercased()
            return PieceKind(rawValue: piece)
        }
        return nil
    }
    
    private func processCastling(san: String, in game: Game) -> Move {
        let file = san == kCastlingKing ? "g" : "c"
        let rank = game.position.state.turn == .white ? "1" : "8"
        return Move(string: "e\(rank)\(file)\(rank)")
    }
    
    private func processPawn(san: String, promotion: PieceKind?, in game: Game) -> Move {
        let move = game.legalMoves
            .filter { $0.to.description == san }
            .filter { game.position.board[$0.from]?.kind == .pawn }
            .first!
        return Move(from: move.from, to: move.to, promotion: promotion)
    }
    
    private func process(san: String, promotion: PieceKind?, in game: Game) -> Move {
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
