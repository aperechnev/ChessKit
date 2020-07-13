//
//  PieceKind.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Represents a piece kind regardless of it's color.
public enum PieceKind: CustomStringConvertible {
    
    /// King piece.
    case king
    
    /// Queen piece.
    case queen
    
    /// Rook piece.
    case rook
    
    /// Bishop piece.
    case bishop
    
    /// Knight piece.
    case knight
    
    /// Pawn piece.
    case pawn
    
    // MARK: CustomStringConvertible
    
    public var description: String {
        switch self {
        case .king: return "k"
        case .queen: return "q"
        case .rook: return "r"
        case .bishop: return "b"
        case .knight: return "n"
        case .pawn: return "p"
        }
    }
    
}
