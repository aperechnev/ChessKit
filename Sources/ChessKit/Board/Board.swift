//
//  ChessBoard.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// A class that represents a chess board with pieces.
public struct Board: Hashable {
    
    internal var bitboards: Bitboards
    
    internal static let fileCoordinates: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h"]
    internal static let rankCoordinates: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    internal static var squaresCount: Int {
        self.fileCoordinates.count * self.rankCoordinates.count
    }
    
    /**
     Initializes board with empty squares.
     */
    public init() {
        self.bitboards = Bitboards()
    }
    
    /**
     Provides access to board squares directly by indexes.
     
     - Parameters:
        - index: Index of square.
     
     - Returns: A `Piece` that put on specified square or `nil` if square is empty.
     */
    public subscript(index: Int) -> Piece? {
        get {
            let squareMask = Bitboard(1) << index
            
            var color: PieceColor! = nil
            if self.bitboards.white & squareMask != Bitboard.zero {
                color = .white
            } else if self.bitboards.black & squareMask != Bitboard.zero {
                color = .black
            }
            guard color != nil else {
                return nil
            }
            
            var kind: PieceKind! = nil
            if self.bitboards.king & squareMask != Bitboard.zero {
                kind = .king
            } else if self.bitboards.queen & squareMask != Bitboard.zero {
                kind = .queen
            } else if self.bitboards.rook & squareMask != Bitboard.zero {
                kind = .rook
            } else if self.bitboards.bishop & squareMask != Bitboard.zero {
                kind = .bishop
            } else if self.bitboards.knight & squareMask != Bitboard.zero {
                kind = .knight
            } else if self.bitboards.pawn & squareMask != Bitboard.zero {
                kind = .pawn
            }
            
            return Piece(kind: kind, color: color)
        }
        set(piece) {
            let squareMask = Bitboard(1) << index
            
            self.bitboards.white &= ~squareMask
            self.bitboards.black &= ~squareMask
            self.bitboards.king &= ~squareMask
            self.bitboards.queen &= ~squareMask
            self.bitboards.rook &= ~squareMask
            self.bitboards.bishop &= ~squareMask
            self.bitboards.knight &= ~squareMask
            self.bitboards.pawn &= ~squareMask
            
            guard let piece = piece else {
                return
            }
            
            switch piece.color {
            case .white:
                self.bitboards.white |= squareMask
            case .black:
                self.bitboards.black |= squareMask
            }
            
            switch piece.kind {
            case .king:
                self.bitboards.king |= squareMask
            case .queen:
                self.bitboards.queen |= squareMask
            case .rook:
                self.bitboards.rook |= squareMask
            case .bishop:
                self.bitboards.bishop |= squareMask
            case .knight:
                self.bitboards.knight |= squareMask
            case .pawn:
                self.bitboards.pawn |= squareMask
            }
        }
    }
    
    /**
     Provides access to board squares via `Square` object.
     
     - Parameters:
        - square: A `Square` on board that should be accessed.
     
     - Returns: A `Piece` that put on specified square or `nil` if square is empty.
     */
    public subscript(square: Square) -> Piece? {
        get {
            return self[square.index]
        }
        set(piece) {
            self[square.index] = piece
        }
    }
    
    /**
     Provides access to board squares via human readable coordinate.
     
     - Parameters:
        - coordinate: A square coordinate in format like `"e4"` or `"d5"`.
     
     - Returns: A `Piece` that put on specified square or `nil` if square is empty.
     */
    public subscript(coordinate: String) -> Piece? {
        get {
            let square = Square(coordinate: coordinate)
            return self[square.index]
        }
        set(piece) {
            let square = Square(coordinate: coordinate)
            self[square.index] = piece
        }
    }
    
    /**
     Provides a list of pieces presented on board.
     
     - Returns: Array of tupples that contain pieces and their squares.
     */
    public func enumeratedPieces() -> [(Square, Piece)] {
        var pieces = [(Square, Piece)]()
        
        for index in Int.zero..<Board.squaresCount {
            if let piece = self[index] {
                let square = Square(index: index)
                pieces.append((square, piece))
            }
        }
        
        return pieces
    }
    
}
