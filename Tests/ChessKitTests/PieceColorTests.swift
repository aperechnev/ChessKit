//
//  PieceColorTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class PieceColorTests: XCTestCase {
    
    func testNegotiation() throws {
        XCTAssertEqual(PieceColor.white, PieceColor.black.negotiated)
        XCTAssertEqual(PieceColor.black, PieceColor.white.negotiated)
    }

}
