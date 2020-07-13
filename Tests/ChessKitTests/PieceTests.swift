//
//  PieceTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class PieceTests: XCTestCase {

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

    func testInitWithCharacter() throws {
        XCTAssertEqual(Piece(character: "K"), Piece(kind: .king, color: .white))
        XCTAssertEqual(Piece(character: "Q"), Piece(kind: .queen, color: .white))
        XCTAssertEqual(Piece(character: "R"), Piece(kind: .rook, color: .white))
        XCTAssertEqual(Piece(character: "B"), Piece(kind: .bishop, color: .white))
        XCTAssertEqual(Piece(character: "N"), Piece(kind: .knight, color: .white))
        XCTAssertEqual(Piece(character: "P"), Piece(kind: .pawn, color: .white))
        
        XCTAssertEqual(Piece(character: "k"), Piece(kind: .king, color: .black))
        XCTAssertEqual(Piece(character: "q"), Piece(kind: .queen, color: .black))
        XCTAssertEqual(Piece(character: "r"), Piece(kind: .rook, color: .black))
        XCTAssertEqual(Piece(character: "b"), Piece(kind: .bishop, color: .black))
        XCTAssertEqual(Piece(character: "n"), Piece(kind: .knight, color: .black))
        XCTAssertEqual(Piece(character: "p"), Piece(kind: .pawn, color: .black))
        
        XCTAssertEqual(Piece(character: "-"), nil)
        XCTAssertEqual(Piece(character: "x"), nil)
        XCTAssertEqual(Piece(character: " "), nil)
    }
    
    func testMapToCharacter() throws {
        XCTAssertEqual("\(Piece(kind: .king, color: .white))", "K")
        XCTAssertEqual("\(Piece(kind: .queen, color: .white))", "Q")
        XCTAssertEqual("\(Piece(kind: .rook, color: .white))", "R")
        XCTAssertEqual("\(Piece(kind: .bishop, color: .white))", "B")
        XCTAssertEqual("\(Piece(kind: .knight, color: .white))", "N")
        XCTAssertEqual("\(Piece(kind: .pawn, color: .white))", "P")
        
        XCTAssertEqual("\(Piece(kind: .king, color: .black))", "k")
        XCTAssertEqual("\(Piece(kind: .queen, color: .black))", "q")
        XCTAssertEqual("\(Piece(kind: .rook, color: .black))", "r")
        XCTAssertEqual("\(Piece(kind: .bishop, color: .black))", "b")
        XCTAssertEqual("\(Piece(kind: .knight, color: .black))", "n")
        XCTAssertEqual("\(Piece(kind: .pawn, color: .black))", "p")
    }

}
