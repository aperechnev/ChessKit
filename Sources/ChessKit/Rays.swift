//
//  Rays.swift
//  ChessKit
//
//  Created by Alexander Perechnev, 2021.
//  Modified by Alexander Perechnev, 2025.
//  Copyright © 2021-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

import Foundation

class Rays {

    private(set) var cross = [Bitboard: Bitboard]()

    init() {
        for index in Bitboard.zero..<64 {
            let key: Bitboard = 0b1 << index
            let value: Bitboard = 0x0101_0101_0101_0101 << (index % 8) | 0xFF << (index / 8 * 8)
            self.cross[key] = value
        }
    }

    func path(between s1: UInt8, and s2: UInt8) -> UInt8 {
        return s1 > s2 ? s1 - 2 * s2 : s2 - 2 * s1
    }

}
