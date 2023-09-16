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
    var televisionOptions: String = ""
    var radioOptions: String = ""
    
//    static var all: [Game] = { get async { } } // TODO get from API
    
    private func getTelevisionOptions(game: ResponseDateGame) -> String {
        return "Apple TV"
    }
    
    private func getRadioOptions(game: ResponseDateGame) -> String {
        return "ATTH, TEX-ES"
    }
    
    init(game: ResponseDateGame) {
        self.gameID = game.gamePk
        self.homeTeam = game.teams.home.team.id
        self.awayTeam = game.teams.away.team.id
        self.date = Date() // TODO parse date
        self.status = game.status.detailedState
        self.televisionOptions = getTelevisionOptions(game: game)
        self.radioOptions = getRadioOptions(game: game)
    }
}
