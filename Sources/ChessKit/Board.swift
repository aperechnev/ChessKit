//
//  ChessBoard.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// A class that represents a chess board with pieces.
public class Board {
    
    /**
     Array of squares on chess board.
     
     The first element is `a1` square, the second is `a2` and `h8` is the last.
     It means that by iterating each element in array you are going through `a1-a8` file first,
     then throught `b1-b8` file and so on up to `h1-h8` file.
     
     The size of array is always equals to its dimensions multiplied by each other.
     */
    fileprivate var squares: [Piece?]
    
    internal static let fileCoordinates: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h"]
    internal static let rankCoordinates: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8"]
    internal static var squaresCount: Int {
        self.fileCoordinates.count * self.rankCoordinates.count
    }
    
    /**
     Initializes board with empty squares.
     */
    public init() {
        self.squares = [Piece?](repeating: nil, count: Board.squaresCount)
    }
    
    /**
     Provides access to board squares directly by indexes.
     
     - Parameters:
        - index: Index of square.
     
     - Returns: A `Piece` that put on specified square or `nil` if square is empty.
     */
    public subscript(index: Int) -> Piece? {
        get {
            return self.squares[index]
        }
        set(piece) {
            self.squares[index] = piece
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
            return self.squares[square.index]
        }
        set(piece) {
            self.squares[square.index] = piece
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
            return self[square]
        }
        set(piece) {
            let square = Square(coordinate: coordinate)
            self[square] = piece
        }
    }
    
    /**
     Makes a deep copy of board.
     
     - Returns: A deep copy of current board.
     */
    public func deepCopy() -> Board {
        let board = Board()
        board.squares = self.squares.map { $0 }
        return board
    }
    
    /**
     Provides a list of pieces presented on board.
     
     - Returns: Array of tupples that contain pieces and their squares.
     */
    public func enumeratedPieces() -> [(Square, Piece)] {
        self.squares.enumerated()
            .filter { $0.element != nil }
            .map { (Square(index: $0.offset), $0.element!) }
    }
    
}
