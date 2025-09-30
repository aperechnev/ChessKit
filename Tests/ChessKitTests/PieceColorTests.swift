//
//  PieceColorTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev, 2020.
//  Modified by Alexander Perechnev, 2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test func negation() {
    #expect(PieceColor.white == PieceColor.black.negotiated)
    #expect(PieceColor.black == PieceColor.white.negotiated)
}
