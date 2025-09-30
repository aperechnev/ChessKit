//
//  PieceColor.swift
//  ChessKit
//
//  Created by Alexander Perechnev, 2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Represents piece and side color.
public enum PieceColor {

    /// White color.
    case white

    /// Black color.
    case black

    /// Negotiates piece color.
    public var negotiated: PieceColor {
        return self == .white ? .black : .white
    }

}
