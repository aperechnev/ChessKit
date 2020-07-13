//
//  FenSerializationTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class FenSerializationTests: XCTestCase {

    func testFenDeserialization() throws {
        let fenList = [
            "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
            "r1bqkbnr/pppp1ppp/2n5/8/2BpP3/5N2/PPP2PPP/RNBQK2R b KQkq - 1 4",
            "r1b1r1k1/pp1nbppp/1q2pn2/2ppN3/3P1B2/2PBPQ2/PP1N1PPP/1R2K2R b K - 4 10",
            "rnbqkbnr/pp2pppp/8/2ppP3/8/8/PPPP1PPP/RNBQKBNR w KQkq d6 0 3",
            "8/8/8/8/4K3/8/8/8 w - - 0 1",
        ]
        
        for fen in fenList {
            let position = FenSerialization.default.deserialize(fen: fen)
            XCTAssertEqual(fen, FenSerialization.default.serialize(position: position))
        }
    }

}
