//
//  CheckmateTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 03.03.2021.
//

import XCTest
@testable import ChessKit

class CheckmateTests: XCTestCase {
    
    func testCheckPositions() throws {
        let positions: [String] = [
            "r3R2k/8/1R4Q1/8/7p/7P/6PK/8 b - - 0 42"
        ]
        
        positions.forEach {
            let position = FenSerialization.default.deserialize(fen: $0)
            let game = Game(position: position)
            
            XCTAssertTrue(game.isCheck)
            XCTAssertFalse(game.isMate)
        }
    }

}
