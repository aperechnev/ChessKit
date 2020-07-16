//
//  Piece.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Piece on `Board` with it's color.
public struct Piece: Hashable, CustomStringConvertible {
    
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
        guard let kind = PieceKind(rawValue: character.lowercased()) else {
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
        let character = self.kind.rawValue
        return self.color == .white ? character.uppercased() : character.lowercased()
    }
    
}
