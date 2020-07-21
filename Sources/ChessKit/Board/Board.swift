//
//  ChessBoard.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// A class that represents a chess board with pieces.
public struct Board: Hashable {
    
    private struct Bitboards: Hashable {
        var white = Int64.zero
        var black = Int64.zero
        var king = Int64.zero
        var queen = Int64.zero
        var rook = Int64.zero
        var bishop = Int64.zero
        var knight = Int64.zero
        var pawn = Int64.zero
    }
    
    private var bitboards: Bitboards
    
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
            let squareMask = Int64(1) << index
            
            var color: PieceColor! = nil
            if self.bitboards.white & squareMask != Int64.zero {
                color = .white
            } else if self.bitboards.black & squareMask != Int64.zero {
                color = .black
            }
            guard color != nil else {
                return nil
            }
            
            var kind: PieceKind! = nil
            if self.bitboards.king & squareMask != Int64.zero {
                kind = .king
            } else if self.bitboards.queen & squareMask != Int64.zero {
                kind = .queen
            } else if self.bitboards.rook & squareMask != Int64.zero {
                kind = .rook
            } else if self.bitboards.bishop & squareMask != Int64.zero {
                kind = .bishop
            } else if self.bitboards.knight & squareMask != Int64.zero {
                kind = .knight
            } else if self.bitboards.pawn & squareMask != Int64.zero {
                kind = .pawn
            }
            
            return Piece(kind: kind, color: color)
        }
        set(piece) {
            let squareMask = Int64(1) << index
            
            self.bitboards.white &= ~squareMask
            self.bitboards.black &= ~squareMask
            self.bitboards.king &= ~squareMask
            self.bitboards.queen &= ~squareMask
            self.bitboards.rook &= ~squareMask
            self.bitboards.bishop &= ~squareMask
            self.bitboards.knight &= ~squareMask
            self.bitboards.pawn &= ~squareMask
            
            if piece?.color == .white {
                self.bitboards.white |= squareMask
            } else if piece?.color == .black {
                self.bitboards.black |= squareMask
            }
            
            if piece?.kind == .king {
                self.bitboards.king |= squareMask
            } else if piece?.kind == .queen {
                self.bitboards.queen |= squareMask
            } else if piece?.kind == .rook {
                self.bitboards.rook |= squareMask
            } else if piece?.kind == .bishop {
                self.bitboards.bishop |= squareMask
            } else if piece?.kind == .knight {
                self.bitboards.knight |= squareMask
            } else if piece?.kind == .pawn {
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
        
        for index in 0..<64 {
            if let piece = self[index] {
                let square = Square(index: index)
                pieces.append((square, piece))
            }
        }
        
        return pieces
    }
    
}
