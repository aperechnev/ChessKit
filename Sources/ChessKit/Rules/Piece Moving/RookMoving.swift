//
//  RookMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class RookMoving: LongRangeMoving {
    
    init() {
        super.init(translations: MovingTranslations.default.cross)
    }
    
}
