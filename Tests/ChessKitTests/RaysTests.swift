//
//  RaysTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 22.03.2021.
//

import XCTest
@testable import ChessKit

class RaysTests: XCTestCase {
    
    private let rays = Rays.default
    
    func testCross() throws {
        XCTAssertEqual(rays.cross[0x0001]!, Bitboard(0x01010101010101FF))
        XCTAssertEqual(rays.cross[0x0800]!, Bitboard(0x080808080808FF08))
        XCTAssertEqual(rays.cross[0x8000]!, Bitboard(0x808080808080FF80))
        XCTAssertEqual(rays.cross[0x8000000000000000]!, Bitboard(0xFF80808080808080))
    }
    
    func testPathBetween() throws {
        let s1: UInt8 = 0b01000000
        let s2: UInt8 = 0b00000010
        let r: UInt8  = 0b00111100
        
        XCTAssertEqual(rays.path(between: s1, and: s2), r)
    }
    
}
