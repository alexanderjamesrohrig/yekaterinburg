//
//  GameAdapter.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation

struct GameAdapter {
    
    static func getGameFrom(_ game: ResponseDateGame) -> Game {
        return Game(game: game)
    }
}
