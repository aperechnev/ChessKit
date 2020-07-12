//
//  Piece.swift
//  ChessBoard
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Piece on `Board` with it's color.
public struct Piece: Equatable, CustomStringConvertible {
    
    private static let kindToCharacterMap: [PieceKind:Character] = [
        .king: "k", .queen: "q", .rook: "r", .bishop: "b", .knight: "n", .pawn: "p"
    ]
    private static let characterToKindMap: [String:PieceKind] = [
        "k": .king, "q": .queen, "r": .rook, "b": .bishop, "n": .knight, "p": .pawn
    ]
    
    /// Piece kind.
    public let kind: PieceKind
    
    /// Piece color.
    public let color: PieceColor
    
    // MARK: Initialization
    
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
    
    /**
     Initializes a piece with given character.
     
     Possible values are: `K` for white king, `n` for black pawn and so on.
     
     - Parameters:
        - character: Character that represents a piece.
     */
    public init?(character: Character) {
        guard let kind: PieceKind = Piece.characterToKindMap[character.lowercased()] else {
            return nil
        }
        let color: PieceColor = character.isUppercase ? .white : .black
        self.init(kind: kind, color: color)
    }
    
    // MARK: Custom string convertable
    
    /**
     String that indicates the stored piece.
     
     Possible values are: `K` for white king, `r` for black rook and so on.
     */
    public var description: String {
        guard let character = Piece.kindToCharacterMap[self.kind] else {
            return "<Error>"
        }
        return self.color == .white ? character.uppercased() : character.lowercased()
    }
    
}
