//
//  BishopMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class BishopMoving: LongRangeMoving {
    
    init() {
        let translations = [(-1, -1), (1, 1), (-1, 1), (1, -1)]
        super.init(translations: translations)
    }
    
}
