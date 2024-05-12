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
    /// <#Description#>
    /// - Parameter game: <#game description#>
    /// - Returns: <#description#>
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
                    televisionOptions: "Paramount+",
                    radioOptions: "",
                    venue: "",
                    type: .game(.calcio))
    }
    /// <#Description#>
    /// - Parameter game: <#game description#>
    /// - Returns: <#description#>
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
                    date: game.gameDate,
                    status: "",
                    televisionOptions: Self.getCallLetters(from: game.content),
                    radioOptions: "",
                    venue: "",
                    type: .game(.baseball))
    }
    
    static func getCallLetters(from content: BaseballResponse.GameContent?) -> String {
        guard let media = content?.media?.epg else {
            logger.debug("EPG is empty")
            return ""
        }
        var returnString = ""
        for m in media {
            if m.title == "MLBTV" {
                guard let items = m.items else {
                    logger.error("No MLBTV stations")
                    return ""
                }
                let lastIndex = items.count - 1
                for i in 0 ..< items.count {
                    returnString.append(items[i].callLetters ?? "")
                    if i != lastIndex {
                        returnString.append(SM.shared.or)
                    }
                }
            }
        }
        return returnString
    }
    
    static func getNHLBroadcasts(_ broadcasts: [HockeyScheduleResponse.Broadcast]?) -> String {
        // TODO: Maybe show first 2 or 3, Ex: "TNT, truTV, and 3 others"
        guard let broadcasts else {
            logger.debug("Empty broadcast information")
            return ""
        }
        var returnString = ""
        let lastIndex = broadcasts.count - 1
        for i in 0 ..< broadcasts.count {
            returnString.append(broadcasts[i].network ?? "")
            if i != lastIndex {
                returnString.append(SM.shared.or)
            }
        }
        return returnString
    }
    
    static func game(from nbaGame: NBAChannelsResponse.NBAStaticGame) -> Game {
        Game(gameID: Int(nbaGame.gameId ?? "") ?? 0,
             homeTeam: 0,
             homeTeamName: "Home",
             homeTeamCode: "",
             homePoints: 0,
             awayTeam: 0,
             awayTeamName: "Away",
             awayTeamCode: "",
             awayPoints: 0,
             date: Date.now,
             status: "\(nbaGame.gameStatus ?? 0)",
             televisionOptions: NBAAPI.channelsString(from: nbaGame.streams),
             radioOptions: "",
             venue: "",
             type: .game(.basketball))
    }
    
    static func games(from: ScoreboardV2) -> [Game] {
        // TODO: Convert to Game
        var games: [Game] = []
        let numberOfGames = from.resultSets?[NBAAPI.ResultSets.gameHeader.rawValue].rowSet?.count
        logger.debug("Games :- \(numberOfGames ?? 0)")
        guard let numberOfGames else {
            return games
        }
        for gameIndex in 0 ..< numberOfGames {
            let gameHeaderInfo = from.resultSets?[NBAAPI.ResultSets.gameHeader.rawValue].rowSet?[gameIndex]
            let gameIDString = gameHeaderInfo?[NBAAPI.GameHeaderKey.gameID.rawValue].toString() ?? ""
            logger.debug("ID :- \(gameIDString)")
            let awayTeamInfoIndex = (gameIndex * 2)
            logger.debug("Away index :- \(awayTeamInfoIndex)")
            let awayTeamInfo = from.resultSets?[NBAAPI.ResultSets.lineScore.rawValue].rowSet?[awayTeamInfoIndex]
            let homeTeamInfoIndex = (gameIndex * 2) + 1
            logger.debug("Home index :- \(homeTeamInfoIndex)")
            let homeTeamInfo = from.resultSets?[NBAAPI.ResultSets.lineScore.rawValue].rowSet?[homeTeamInfoIndex]
            let gameDateString = gameHeaderInfo?[NBAAPI.GameHeaderKey.gameDateEST.rawValue].toString() ?? ""
            logger.debug("Date :- \(gameDateString)")
            let gameDate = DateAdapter.dateFrom(gameDateString)
            var broadcasts = gameHeaderInfo?[NBAAPI.GameHeaderKey.nationalTVBroadcaster.rawValue].toString() ?? ""
            if let awayBroadcast = gameHeaderInfo?[NBAAPI.GameHeaderKey.awayTVBroadcaster.rawValue].toString(),
               !awayBroadcast.isEmpty{
                broadcasts.append("\(StringManager.shared.or)\(awayBroadcast)")
            }
            if let homeBroadcast = gameHeaderInfo?[NBAAPI.GameHeaderKey.homeTVBroadcaster.rawValue].toString(),
               !homeBroadcast.isEmpty {
                broadcasts.append("\(StringManager.shared.or)\(homeBroadcast)")
            }
            logger.debug("Broadcasts :- \(gameDateString)")
            let gameAtIndex = Game(gameID: Int(gameIDString) ?? 0,
                                   homeTeam: homeTeamInfo?[NBAAPI.LineScoreKey.teamID.rawValue].toInt() ?? 0,
                                   homeTeamName: homeTeamInfo?[NBAAPI.LineScoreKey.teamCityName.rawValue].toString() ?? "",
                                   homeTeamCode: homeTeamInfo?[NBAAPI.LineScoreKey.teamAbbreviation.rawValue].toString() ?? "",
                                   homePoints: 0,
                                   awayTeam: awayTeamInfo?[NBAAPI.LineScoreKey.teamID.rawValue].toInt() ?? 0,
                                   awayTeamName: awayTeamInfo?[NBAAPI.LineScoreKey.teamCityName.rawValue].toString() ?? "",
                                   awayTeamCode: awayTeamInfo?[NBAAPI.LineScoreKey.teamAbbreviation.rawValue].toString() ?? "",
                                   awayPoints: 0,
                                   date: gameDate,
                                   status: gameHeaderInfo?[NBAAPI.GameHeaderKey.gameStatusText.rawValue].toString() ?? "",
                                   televisionOptions: broadcasts,
                                   radioOptions: "",
                                   venue: gameHeaderInfo?[NBAAPI.GameHeaderKey.arenaName.rawValue].toString() ?? "",
                                   type: .game(.basketball))
            games.append(gameAtIndex)
        }
        return games
    }
    
    private init() {}
}
