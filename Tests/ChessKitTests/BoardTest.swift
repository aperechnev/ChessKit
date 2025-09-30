//
//  BoardTest.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Modified by Alexander Perechnev on 30.09.2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test func accessBySquare() {
    var board = Board()

    for index in 0..<64 {
        let square = Square(index: index)
        #expect(board[square] == nil)
    }

    let e4 = Square(file: 4, rank: 1)
    let whitePawn = Piece(kind: .pawn, color: .white)

    board[e4] = whitePawn
    #expect(whitePawn == board[e4])

    board[e4] = nil
    #expect(board[e4] == nil)
}

@Test func accessByCoordinates() {
    var board = Board()

    let whitePawn = Piece(kind: .pawn, color: .white)
    board["e4"] = whitePawn

    #expect(whitePawn == board["e4"])
}

@Test func accessByIndex() {
    var board = Board()

    let whitePawn = Piece(kind: .pawn, color: .white)
    let e4square = Square(coordinate: "e4")

    board[e4square.index] = whitePawn

    #expect(board[e4square] == whitePawn)
    #expect(board[e4square.index] == whitePawn)
}

@Test func deepCopy() {
    let whitePawn = Piece(kind: .pawn, color: .white)

    var board = Board()
    board["e4"] = whitePawn

    var boardCopy = board
    boardCopy["e4"] = nil

    #expect(board["e4"] == whitePawn)
}

@Test func enumeratedPieces() {
    var board = Board()
    board["e4"] = Piece(kind: .pawn, color: .white)
    board["c5"] = Piece(kind: .pawn, color: .black)

    #expect(board.enumeratedPieces().count == 2)
}
