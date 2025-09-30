//
//  CheckmateTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev, 2021.
//  Modified by Alexander Perechnev, 2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test func check() throws {
    let fenSerializator = FenSerialization()
    let positions: [String] = [
        "r3R2k/8/1R4Q1/8/7p/7P/6PK/8 b - - 0 42"
    ]

    positions.forEach {
        let position = fenSerializator.deserialize(fen: $0)
        let game = Game(position: position)

        #expect(game.isCheck == true)
        #expect(game.isMate == false)
    }
}
