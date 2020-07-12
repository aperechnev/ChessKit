//
//  PieceTest.swift
//  ChessBoardTests
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class PieceTest: XCTestCase {

    func testEquatability() throws {
        XCTAssertEqual(
            Piece(kind: .knight, color: .black),
            Piece(kind: .knight, color: .black)
        )
        XCTAssertNotEqual(
            Piece(kind: .pawn, color: .white),
            Piece(kind: .pawn, color: .black)
        )
        XCTAssertNotEqual(
            Piece(kind: .king, color: .white),
            Piece(kind: .queen, color: .white)
        )
    }

}
