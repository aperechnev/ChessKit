//
//  SquareTest.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class SquareTest: XCTestCase {
    
    func testInitWithIndex() throws {
        for index in 0..<64 {
            let square = Square(index: index)
            XCTAssertEqual(square.index, index)
            XCTAssertTrue(square.isValid)
        }
    }
    
    func testInitWithFileAndRank() throws {
        for file in 0...7 {
            for rank in 0...7 {
                let square = Square(file: file, rank: rank)
                XCTAssertEqual(file, square.file)
                XCTAssertEqual(rank, square.rank)
            }
        }
    }
    
    func testInitWithCoordinate() throws {
        XCTAssertEqual(Square(coordinate: "a1"), Square(file: 0, rank: 0))
        XCTAssertEqual(Square(coordinate: "e4"), Square(file: 4, rank: 3))
        XCTAssertEqual(Square(coordinate: "h8"), Square(file: 7, rank: 7))
        
        XCTAssertFalse(Square(coordinate: "").isValid)
        XCTAssertFalse(Square(coordinate: "z9").isValid)
    }
    
    func testGettingCoordinate() throws {
        let coordinates = ["a1", "e4", "d5", "h8"]
        
        for coordinate in coordinates {
            let square = Square(coordinate: coordinate)
            
            XCTAssertEqual(square.coordinate, coordinate)
            XCTAssertEqual("\(square)", coordinate)
        }
    }
    
    func testSquareTranslation() {
        let e4Square = Square(coordinate: "e4")
        XCTAssertEqual(e4Square.translate(file: -1, rank: 1).coordinate, "d5")
    }

}
