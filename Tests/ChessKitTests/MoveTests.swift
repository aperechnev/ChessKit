//
//  MoveTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class MoveTests: XCTestCase {
    
    func testInitWithSquares() throws {
        XCTAssertEqual(
            Move(from: Square(coordinate: "e2"), to: Square(coordinate: "e4")).description,
            "e2e4"
        )
        
        XCTAssertEqual(
            Move(from: Square(coordinate: "d7"), to: Square(coordinate: "d8"), promotion: PieceKind.queen).description,
            "d7d8q"
        )
    }
    
    func testInitWithString() throws {
        XCTAssertEqual(Move(string: "e2e4").description, "e2e4")
        XCTAssertEqual(Move(string: "f7f8r").description, "f7f8r")
    }

}
