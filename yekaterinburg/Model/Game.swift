//
//  Game.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/5/23.
//

import Foundation

struct Game {
    
    var gameID: Int
    var homeTeam: Int
    var awayTeam: Int
    var date: Date
    var status: String
    
    // TODO
//    static var all: [Game] = {
//        get async {
//            let url = URL(string: "")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let decoded = try JSONDecoder().decode(Response.self, from: data)
//        }
//    }
    
    init(game: ResponseDateGame) {
        self.gameID = game.gamePk
        self.homeTeam = game.teams.home.team.id
        self.awayTeam = game.teams.away.team.id
//        self.date = game.gameDate
        self.date = Date() // TODO
        self.status = game.status.detailedState
    }
}
