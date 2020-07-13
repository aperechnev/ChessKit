//
//  MovesTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class MovesTests: XCTestCase {
    
    func assert(fen: String, targets: String, at coordinate: String) {
        let position = FenSerialization.default.deserialize(fen: fen)
        let square = Square(coordinate: coordinate)
        let moves = targets.split(separator: " ").map { "\(square)\($0)" }
        let testMoves = StandardRules().movesForPiece(at: square, in: position)
        XCTAssertEqual(moves.sorted(), testMoves.map({ $0.description }).sorted(), "Position: \(fen)")
    }
    
    func assert(fen: String, testMoves: String) {
        let position = FenSerialization.default.deserialize(fen: fen)
        let testMoves = testMoves.split(separator: " ").map { "\($0)" }
        let legalMoves = StandardRules().legalMoves(in: position)
        XCTAssertEqual(legalMoves.map({ $0.description }).sorted(), testMoves.sorted(), "Position: \(fen)")
    }

}
