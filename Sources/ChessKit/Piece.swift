//
//  Piece.swift
//  ChessBoard
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Piece on `Board` with it's color.
public struct Piece: Equatable {
    
    /// Piece kind.
    public let kind: PieceKind
    
    /// Piece color.
    public let color: PieceColor
    
    /**
     Initializes a piece with it's kind and color.
     
     - Parameters:
        - kind: Piece kind.
        - color: Piece color.
     */
    public init(kind: PieceKind, color: PieceColor) {
        self.kind = kind
        self.color = color
    }
    
    public init?(character: Character) {
        let color: PieceColor = character.isUppercase ? .white : .black
        let kind: PieceKind
        
        switch character.lowercased() {
        case "k": kind = .king
        case "q": kind = .queen
        case "r": kind = .rook
        case "b": kind = .bishop
        case "n": kind = .knight
        case "p": kind = .pawn
        default: return nil
        }
        
        self.init(kind: kind, color: color)
    }
    
}

extension Piece: CustomStringConvertible {
    
    public var description: String {
        let map: [PieceKind:Character] = [
            .king: "k", .queen: "q", .rook: "r", .bishop: "b", .knight: "n", .pawn: "p"
        ]
        
        guard let character = map[self.kind] else {
            return "<Error>"
        }
        
        return self.color == .white ? character.uppercased() : character.lowercased()
    }
    
}
