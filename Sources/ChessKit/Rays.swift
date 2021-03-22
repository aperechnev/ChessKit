//
//  Rays.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 22.03.2021.
//

import Foundation

class Rays {
    
    private(set) var cross = [Bitboard:Bitboard]()
    
    static let `default` = Rays()
    
    init() {
        for index in Bitboard.zero ..< 64 {
            let key: Bitboard = 0b1 << index
            let value: Bitboard = 0x0101010101010101 << (index % 8) | 0xFF << (index / 8 * 8)
            self.cross[key] = value
        }
    }
    
    func path(between s1: UInt8, and s2: UInt8) -> UInt8 {
        return s1 > s2 ? s1 - 2 * s2 : s2 - 2 * s1
    }
    
}
