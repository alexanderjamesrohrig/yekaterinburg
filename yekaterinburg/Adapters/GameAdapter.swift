//
//  GameAdapter.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation

struct GameAdapter {
    /// Returns Game given game from MLB API
    static func getGameFrom(_ game: ResponseDateGame) -> Game {
        return Game(game: game)
    }
    /// Returns Game given game from NHL API
    static func getGameFrom(_ game: HockeyResponse.NHLDate.NHLGame) -> Game {
        return Game(gameID: game.gamePk,
                    homeTeam: game.teams.home.team.id,
                    homeTeamName: game.teams.home.team.name,
                    homeTeamCode: "", // TODO: Home team code
                    homePoints: game.teams.home.score,
                    awayTeam: game.teams.away.team.id,
                    awayTeamName: game.teams.away.team.name,
                    awayTeamCode: "", // TODO: Away team code
                    awayPoints: game.teams.away.score,
                    date: game.gameDate,
                    status: game.status.detailedState,
                    televisionOptions: "", // TODO: Television
                    radioOptions: "", // TODO: Radio
                    venue: "", // TODO: Venue
                    type: .game(.hockey))
    }
    /// Returns Game given game from NBA API
    static func getGameFrom(_ game: BasketballResponse.BBallGame) -> Game {
        return Game(gameID: game.id,
                    homeTeam: game.home_team.id,
                    homeTeamName: game.home_team.city,
                    homeTeamCode: game.home_team.abbreviation,
                    homePoints: game.home_team_score,
                    awayTeam: game.visitor_team.id,
                    awayTeamName: game.visitor_team.city,
                    awayTeamCode: game.visitor_team.abbreviation,
                    awayPoints: game.visitor_team_score,
                    date: game.date,
                    status: "", // TODO: Television
                    televisionOptions: "", // TODO: Television
                    radioOptions: "", // TODO: Radio
                    venue: "", // TODO: Venue
                    type: .game(.basketball))
    }
    /// Returns Game given game from NCAA Football API
    static func getGameFrom(_ game: CollegeFootballGame) -> Game {
        return Game(gameID: game.id,
                    homeTeam: game.home_id,
                    homeTeamName: game.home_team,
                    homeTeamCode: "", // TODO: Home team code
                    homePoints: game.home_points,
                    awayTeam: game.away_id,
                    awayTeamName: game.away_team,
                    awayTeamCode: "", // TODO: Away team code
                    awayPoints: game.away_points,
                    date: game.start_date,
                    status: "", // TODO: Television
                    televisionOptions: "", // TODO: Television
                    radioOptions: "", // TODO: Radio
                    venue: game.venue,
                    type: .game(.collegeFootball))
    }
    private init() {}
}
