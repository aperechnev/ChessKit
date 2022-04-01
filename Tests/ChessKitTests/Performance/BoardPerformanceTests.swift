//
//  BoardPerformanceTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 25.08.2021.
//

import XCTest
@testable import ChessKit

class BoardPerformanceTests: XCTestCase {
    
    private let board = Board()
    private let range = 0 ..< 100_000
    
    private let coordinate = "e4"
    private let square = Square(coordinate: "e4")
    private let index = Square(coordinate: "e4").index
    
    func testAccessByCoordinatePerformance() throws {
        self.measure {
            range.forEach { _ in let _ = board["e4"] }
        }
    }
    
    func testAccessBySquarePerformance() throws {
        self.measure {
            range.forEach { _ in let _ = board[square] }
        }
    }
    
    func testAccessByIndexPerformance() throws {
        self.measure {
            range.forEach { _ in let _ = board[index] }
        }
    }

}
