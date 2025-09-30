//
//  PieceColorTests.swift
//  ChessKitTests
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Modified by Alexander Perechnev on 30.09.2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Testing

@testable import ChessKit

@Test func negation() {
    #expect(PieceColor.white == PieceColor.black.negotiated)
    #expect(PieceColor.black == PieceColor.white.negotiated)
}
