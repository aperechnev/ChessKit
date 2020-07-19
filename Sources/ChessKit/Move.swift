//
//  Move.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

/// Represents move on board.
public struct Move: CustomStringConvertible, Hashable {
    
    /// Square where piece goes from.
    public let from: Square
    
    /// Square where piece goes to.
    public let to: Square
    
    /// Indicates if move promotes pawn into piece.
    public let promotion: PieceKind?
    
    // MARK: Initialization
    
    /**
     Initialize move with start and end squares.
     
     - Parameters:
        - from: Square where piece goes from.
        - to: Square where piece goes to.
        - promotion: A piece kind which should be set instead of pawn in case of promotion.
     */
    public init(from: Square, to: Square, promotion: PieceKind? = nil) {
        self.from = from
        self.to = to
        self.promotion = promotion
    }
    
    /**
     Initialize move with human readable string.
     
     - Parameters:
        - string: Move string in human readable format (e.g., `"g1f3"`, `"e7e8Q"`).
     */
    public init(string: String) {
        let fromIndex = string.index(string.startIndex, offsetBy: 2)
        let fromString = string[..<fromIndex].description
        self.from = Square(coordinate: fromString)
        
        let toIndex = string.index(string.startIndex, offsetBy: 4)
        let toString = string[fromIndex..<toIndex].description
        self.to = Square(coordinate: toString)
        
        if let promotionCharacter = string.last {
            self.promotion = Piece(character: promotionCharacter)?.kind
        } else {
            self.promotion = nil
        }
    }
    
    // MARK: CustomStringConvertible
    
    /// Converts move into human readable string format.
    public var description: String {
        var result = "\(self.from)\(self.to)"
        
        if let promotion = self.promotion {
            result += "\(promotion)"
        }
        
        return result
    }
    
}
