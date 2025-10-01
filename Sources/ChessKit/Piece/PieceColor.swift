//
//  PieceColor.swift
//  ChessKit
//
//  Created by Alexander Perechnev, 2020.
//  Modified by Alexander Perechnev, 2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import libchess

/// Represents piece and side color.
public enum PieceColor {

    /// White color.
    case white

    /// Black color.
    case black

    internal init(side: side_t) {
        self = side == SIDE_WHITE ? .white : .black
    }

    /// Negotiates piece color.
    public var negotiated: PieceColor {
        PieceColor(side: negate_side(self.side))
    }

    internal var side: side_t {
        self == .white ? SIDE_WHITE : SIDE_BLACK
    }

}
