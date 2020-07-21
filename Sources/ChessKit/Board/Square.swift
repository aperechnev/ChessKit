//
//  Square.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Square on `Board`.
public struct Square: Hashable {
    
    private(set) var index: Int
    let bitboardMask: Bitboard
    
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
    private(set) var isValid: Bool
    
    // MARK: Initializers
    
    init(bitboardMask: Bitboard) {
        self.bitboardMask = bitboardMask
        self.index = 0
        self.isValid = bitboardMask > Int64.zero
        
        var mask = bitboardMask
        while mask > 1 {
            mask = mask >> 1
            self.index += 1
        }
    }
    
    /**
     Initializes `Square` with its index.
     
     - Parameters:
     - index: Index of square in `Board.squares` array.
     */
    public init(index: Int) {
        self.index = index
        self.bitboardMask = 1 << index
        self.isValid = (Int.zero..<Board.squaresCount).contains(self.index)
    }
    
    /**
     Initializes `Square` with file and rank indexes.
     
     - Parameters:
     - file: File index (from 0 to 7).
     - rank: Rank index (from 0 to 7).
     */
    public init(file: Int, rank: Int) {
        self.init(index: file * Board.rankCoordinates.count + rank)
        self.isValid = (Int.zero...7).contains(file) && (Int.zero...7).contains(rank)
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

extension Square: CustomStringConvertible {
    
    public var description: String {
        return self.coordinate
    }
    
}
