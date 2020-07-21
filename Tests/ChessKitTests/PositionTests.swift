//
//  PositionTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class PositionTests: XCTestCase {
    
    func testDeepCopying() throws {
        let initialFen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
        let position = FenSerialization.default.deserialize(fen: initialFen)
        
        var positionCopy = position
        positionCopy.board["e4"] = nil
        positionCopy.state.castlings = []
        positionCopy.state.enPasant = Square(coordinate: "e4")
        positionCopy.state.turn = .black
        positionCopy.counter.fullMoves = 100
        positionCopy.counter.halfMoves = 200
        
        XCTAssertEqual(FenSerialization.default.serialize(position: position), initialFen)
    }

}
