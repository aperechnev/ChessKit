//
//  MovingTranslations.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 13.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

class MovingTranslations {
    
    static let `default` = MovingTranslations()
    
    private(set) lazy var diagonal = [
        (-1, -1), (1, 1), (-1, 1), (1, -1)
    ]
    private(set) lazy var cross = [
        (-1, 0), (0, 1), (1, 0), (0, -1)
    ]
    private(set) lazy var crossDiagonal = {
        self.cross + self.diagonal
    }()
    private(set) lazy var knight = [
        (-2, 1), (-1, 2), (1, 2), (2, 1), (2, -1), (1, -2), (-1, -2), (-2, -1)
    ]
    private(set) lazy var pawnTaking = [
        (-1, 1), (1, 1)
    ]
    
}
