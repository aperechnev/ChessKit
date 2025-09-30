//
//  PieceTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev, 2020.
//  Modified by Alexander Perechnev, 2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test func equatability() {
    #expect(
        Piece(kind: .knight, color: .black) == Piece(kind: .knight, color: .black)
    )
    #expect(
        Piece(kind: .pawn, color: .white) != Piece(kind: .pawn, color: .black)
    )
    #expect(
        Piece(kind: .king, color: .white) != Piece(kind: .queen, color: .white)
    )
}

@Test func initWithCharacter() {
    #expect(Piece(character: "K") == Piece(kind: .king, color: .white))
    #expect(Piece(character: "Q") == Piece(kind: .queen, color: .white))
    #expect(Piece(character: "R") == Piece(kind: .rook, color: .white))
    #expect(Piece(character: "B") == Piece(kind: .bishop, color: .white))
    #expect(Piece(character: "N") == Piece(kind: .knight, color: .white))
    #expect(Piece(character: "P") == Piece(kind: .pawn, color: .white))

    #expect(Piece(character: "k") == Piece(kind: .king, color: .black))
    #expect(Piece(character: "q") == Piece(kind: .queen, color: .black))
    #expect(Piece(character: "r") == Piece(kind: .rook, color: .black))
    #expect(Piece(character: "b") == Piece(kind: .bishop, color: .black))
    #expect(Piece(character: "n") == Piece(kind: .knight, color: .black))
    #expect(Piece(character: "p") == Piece(kind: .pawn, color: .black))

    #expect(Piece(character: "-") == nil)
    #expect(Piece(character: "x") == nil)
    #expect(Piece(character: " ") == nil)
}

@Test func mapToCharacter() {
    #expect("\(Piece(kind: .king, color: .white))" == "K")
    #expect("\(Piece(kind: .queen, color: .white))" == "Q")
    #expect("\(Piece(kind: .rook, color: .white))" == "R")
    #expect("\(Piece(kind: .bishop, color: .white))" == "B")
    #expect("\(Piece(kind: .knight, color: .white))" == "N")
    #expect("\(Piece(kind: .pawn, color: .white))" == "P")

    #expect("\(Piece(kind: .king, color: .black))" == "k")
    #expect("\(Piece(kind: .queen, color: .black))" == "q")
    #expect("\(Piece(kind: .rook, color: .black))" == "r")
    #expect("\(Piece(kind: .bishop, color: .black))" == "b")
    #expect("\(Piece(kind: .knight, color: .black))" == "n")
    #expect("\(Piece(kind: .pawn, color: .black))" == "p")
}
