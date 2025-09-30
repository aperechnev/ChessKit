//
//  RookMoving.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Modified by Alexander Perechnev on 30.09.2025.
//  Copyright © 2020-2025 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class RookMoving: LongRangeMoving {

    init() {
        super.init(translations: MovingTranslations().cross)
    }

}
