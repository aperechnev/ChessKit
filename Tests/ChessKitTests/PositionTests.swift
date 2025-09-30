//
//  PositionTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Modified by Alexander Perechnev on 30.09.2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test func deepCopying() {
    let fenSerializator = FenSerialization()
    let initialFen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    let position = fenSerializator.deserialize(fen: initialFen)

    var positionCopy = position
    positionCopy.board["e4"] = nil
    positionCopy.state.castlings = []
    positionCopy.state.enPasant = Square(coordinate: "e4")
    positionCopy.state.turn = .black
    positionCopy.counter.fullMoves = 100
    positionCopy.counter.halfMoves = 200

    #expect(fenSerializator.serialize(position: position) == initialFen)
}
