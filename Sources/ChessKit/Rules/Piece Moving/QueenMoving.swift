//
//  QueenMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class QueenMoving: LongRangeMoving {
    
    init() {
        super.init(translations: MovingTranslations.default.crossDiagonal)
    }
    
}
