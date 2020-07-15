//
//  PieceKind.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Represents a piece kind regardless of it's color.
public enum PieceKind: String, CustomStringConvertible {
    
    /// King piece.
    case king = "k"
    
    /// Queen piece.
    case queen = "q"
    
    /// Rook piece.
    case rook = "r"
    
    /// Bishop piece.
    case bishop = "b"
    
    /// Knight piece.
    case knight = "n"
    
    /// Pawn piece.
    case pawn = "p"
    
    // MARK: CustomStringConvertible
    
    /// Converts itself into human readable character.
    public var description: String {
        return self.rawValue
    }
    
}
