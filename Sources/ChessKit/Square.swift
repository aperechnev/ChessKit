//
//  Square.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Square on `Board`.
public struct Square {
    
    /// Index of square in `Board.squares` array.
    internal let index: Int
    
    /// Index of file of the square.
    public var file: Int {
        self.index / Board.rankCoordinates.count
    }
    
    /// Index of rank of the square.
    public var rank: Int {
        self.index % Board.fileCoordinates.count
    }
    
    /// Human readable coorsinate on the square.
    public var coordinate: String {
        let file = Board.fileCoordinates[self.file]
        let rank = Board.rankCoordinates[self.rank]
        return "\(file)\(rank)"
    }
    
    /// Indicates whether if square is valid.
    public var isValid: Bool {
        return (Int.zero..<Board.squaresCount).contains(self.index)
    }
    
    // MARK: Initializers
    
    /**
     Initializes `Square` with its index.
     
     - Parameters:
     - index: Index of square in `Board.squares` array.
     */
    public init(index: Int) {
        self.index = index
    }
    
    /**
     Initializes `Square` with file and rank indexes.
     
     - Parameters:
     - file: File index (from 0 to 7).
     - rank: Rank index (from 0 to 7).
     */
    public init(file: Int, rank: Int) {
        self.init(index: file * Board.rankCoordinates.count + rank)
    }
    
    /**
     Initializes a square from human readable coordinate string.
     
     - Parameters:
        - coordinate: Square coordinate in format like: `"e4"`, `"d5"`, etc.
     */
    public init(coordinate: String) {
        let fileCharacter = coordinate.first ?? "-"
        let rankCharacter = coordinate.last ?? "-"
        
        let file = Board.fileCoordinates.firstIndex(of: fileCharacter) ?? -1
        let rank = Board.rankCoordinates.firstIndex(of: rankCharacter) ?? -1
        
        if file == -1 || rank == -1 {
            self.init(index: -1)
        } else {
            self.init(file: file, rank: rank)
        }
    }
    
    /**
     Creates new square with file and rank offsets.
     
     - Parameters:
        - file: File offset.
        - rank: Rank offset.
     
     - Returns: New square with necessary offset.
     */
    public func translate(file: Int, rank: Int) -> Square {
        return Square(file: self.file + file, rank: self.rank + rank)
    }
    
}

extension Square: Equatable {
    
    public static func == (lhs: Square, rhs: Square) -> Bool {
        return lhs.index == rhs.index
    }
    
}

extension Square: CustomStringConvertible {
    
    public var description: String {
        return self.coordinate
    }
    
}
