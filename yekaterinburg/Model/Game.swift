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
    
    static func gamesFor(team: Int, forDate date: Date) async throws -> [Game] {
        let date = DateAdapter.dateForAPI(date: Date())
        let gamesURL = "schedule?sportId=1&teamId=\(team)&date=\(date)&season=2023&hydrate=team"
        let url = URL(string: MLB.BASE_URL + gamesURL)
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        var games: [Game] = []
        
        if let x = decoded.dates.first {
            for g in x.games {
                games.append(Game(game: g))
            }
        }
        
        return games
    }
    
    static func allFor(team: Int) async throws -> [Game] {
        let gamesURL = "schedule?sportId=1&teamId=\(team)&season=2023&hydrate=team"
        let url = URL(string: MLB.BASE_URL + gamesURL)
        let (data, _) = try await URLSession.shared.data(from: url!)
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        var games: [Game] = []
        
        for date in decoded.dates {
            for game in date.games {
                games.append(Game(game: game))
            }
        }
        
        return games
    }
    
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
        self.date = DateAdapter.dateFromAPI(date: game.gameDate)
        self.status = game.status.detailedState
        self.televisionOptions = getTelevisionOptions(game: game)
        self.radioOptions = getRadioOptions(game: game)
    }
}
