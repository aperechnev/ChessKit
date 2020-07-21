//
//  BoardTest.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 11.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import XCTest
@testable import ChessKit

class BoardTest: XCTestCase {
    
    func testAccessBySquare() throws {
        var board = Board()
        
        for index in 0..<64 {
            let square = Square(index: index)
            XCTAssertNil(board[square])
        }
        
        let e4 = Square(file: 4, rank: 1)
        let whitePawn = Piece(kind: .pawn, color: .white)
        
        board[e4] = whitePawn
        XCTAssertEqual(whitePawn, board[e4])
        
        board[e4] = nil
        XCTAssertNil(board[e4])
    }
    
    func testAccessByCoordinates() throws {
        var board = Board()
        
        let whitePawn = Piece(kind: .pawn, color: .white)
        board["e4"] = whitePawn
        
        XCTAssertEqual(whitePawn, board["e4"])
    }
    
    func testAccessByIndex() throws {
        var board = Board()
        
        let whitePawn = Piece(kind: .pawn, color: .white)
        let e4square = Square(coordinate: "e4")
        
        board[e4square.index] = whitePawn
        
        XCTAssertEqual(board[e4square], whitePawn)
        XCTAssertEqual(board[e4square.index], whitePawn)
    }
    
    func testDeepCopy() throws {
        let whitePawn = Piece(kind: .pawn, color: .white)
        
        var board = Board()
        board["e4"] = whitePawn
        
        var boardCopy = board
        boardCopy["e4"] = nil
        
        XCTAssertEqual(board["e4"], whitePawn)
    }
    
    func testENumeratedPieces() throws {
        var board = Board()
        board["e4"] = Piece(kind: .pawn, color: .white)
        board["c5"] = Piece(kind: .pawn, color: .black)
        
        XCTAssertEqual(board.enumeratedPieces().count, 2)
    }

}
