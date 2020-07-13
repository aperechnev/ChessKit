//
//  Game.swift
//  ChessKit
//
//  Created by Alexander Perechnev on 12.07.2020.
//  Copyright © 2020 Päike Mikrosüsteemid OÜ. All rights reserved.
//

public class Game {
    
    private let position: Position
    private let rules: Rules
    
    public init(position: Position, rules: Rules) {
        self.position = position
        self.rules = rules
    }
    
}
