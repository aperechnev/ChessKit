//
//  MoveTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Modified by Alexander Perechnev on 30.09.2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test func initWithSquares() {
    #expect(
        Move(from: Square(coordinate: "e2"), to: Square(coordinate: "e4")).description == "e2e4"
    )

    #expect(
        Move(
            from: Square(coordinate: "d7"), to: Square(coordinate: "d8"),
            promotion: PieceKind.queen
        ).description == "d7d8q"
    )
}

@Test func initWithString() {
    #expect(Move(string: "e2e4").description == "e2e4")
    #expect(Move(string: "f7f8r").description == "f7f8r")
}
