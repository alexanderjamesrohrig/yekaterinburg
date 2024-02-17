//
//  GameAdapter.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation
import OSLog

fileprivate let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "GameAdapter")

struct GameAdapter {
    /// Returns Game given game from MLB API
    static func getGameFrom(_ game: ResponseDateGame) -> Game {
        return Game(gameID: game.gamePk,
                    homeTeam: game.teams.home.team.id,
                    homeTeamName: game.teams.home.team.franchiseName,
                    homeTeamCode: "",
                    homePoints: 0,
                    awayTeam: game.teams.away.team.id,
                    awayTeamName: game.teams.away.team.franchiseName,
                    awayTeamCode: "",
                    awayPoints: 0,
                    date: DateAdapter.dateFromAPI(date: game.gameDate),
                    status: game.status.detailedState,
                    televisionOptions: "",
                    radioOptions: "",
                    venue: "",
                    type: .game(.baseball))
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
        var status = game.status ?? "Unknown"
        var date = DateAdapter.dateFromShortString(date: game.date ?? "2001-08-09")
        if status != "Final" {
            date = DateAdapter.dateFromISO(date: status)
            status = "Scheduled"
        }
        return Game(gameID: game.id,
                    homeTeam: game.home_team?.id ?? 0,
                    homeTeamName: game.home_team?.city ?? "",
                    homeTeamCode: game.home_team?.abbreviation ?? "",
                    homePoints: game.home_team_score ?? 0,
                    awayTeam: game.visitor_team?.id ?? 0,
                    awayTeamName: game.visitor_team?.city ?? "",
                    awayTeamCode: game.visitor_team?.abbreviation ?? "",
                    awayPoints: game.visitor_team_score ?? 0,
                    date: date,
                    status: status,
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
    static func getGameFrom(footballGame game: WorldFootballResponse.Match) -> Game {
        // TODO: Fill remaining
        return Game(gameID: game.id,
                    homeTeam: 0,
                    homeTeamName: game.homeTeam.shortName,
                    homeTeamCode: "",
                    homePoints: 0,
                    awayTeam: 0,
                    awayTeamName: game.awayTeam.shortName,
                    awayTeamCode: "",
                    awayPoints: 0,
                    date: DateAdapter.dateFromISO(date: game.utcDate),
                    status: game.status,
                    televisionOptions: "",
                    radioOptions: "",
                    venue: "",
                    type: .game(.calcio))
    }
    static func getGameFrom(baseballGame game: BaseballResponse.MLBDate.MLBGame) -> Game {
        return Game(gameID: game.gamePk,
                    homeTeam: game.teams.home.team.id,
                    homeTeamName: game.teams.home.team.name,
                    homeTeamCode: "",
                    homePoints: 0,
                    awayTeam: game.teams.away.team.id,
                    awayTeamName: game.teams.away.team.name,
                    awayTeamCode: "",
                    awayPoints: 0,
                    date: DateAdapter.dateFromISO(date: game.gameDate),
                    status: "",
                    televisionOptions: "",
                    radioOptions: "",
                    venue: "",
                    type: .game(.baseball))
    }
    private init() {}
}
