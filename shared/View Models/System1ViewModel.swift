//
//  System1ViewModel.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/12/24.
//

import Foundation
import OSLog

@Observable class System1ViewModel {
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "System1ViewModel")
    var twoDaysAgo: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: -2, to: Date.now) ?? Date.now
    }
    var games = [Game]()
    
    /// Returns array of Game objects from API and local sources
    /// - Parameter sources: Set of YeType, used to decide which APIs to fetch from.
    /// - Returns: Array of Game objects
    func getGamesFrom(sources: Set<YeType>,
                      useMockData: Bool = false,
                      includePastGames: Bool = false,
                      loadLocalGames: Bool = false) async -> [Game] {
        var games: [Game] = []
        /// Calcio
        if sources.contains(.game(.calcio)) {
            let gamesFromAPI = await WorldFootballAPI.games(useMockData: useMockData)?.matches
            if let gamesFromAPI {
                for g in gamesFromAPI {
                    let adaptedGame = GameAdapter.getGameFrom(footballGame: g)
                    if adaptedGame.date > twoDaysAgo {
                        games.append(adaptedGame)
                    }
                }
            }
        }
        /// Baseball
        if sources.contains(.game(.baseball)) {
            let datesAndGamesFromAPI = await MLBAPI.games(useMockData: useMockData)
            if let dates = datesAndGamesFromAPI?.dates {
                for d in dates {
                    for g in d.games {
                        let adaptedGame = GameAdapter.getGameFrom(baseballGame: g)
                        if adaptedGame.date > twoDaysAgo {
                            games.append(adaptedGame)
                        }
                    }
                }
            }
        }
        /// Professional Football
        /// https://plaintextsports.com/nfl/2023/schedule
        /// College Football
        ///
//        if sources.contains(.game(.collegeFootball)) {
//            // TODO: NCAA
//        }
        /// Hockey
        if sources.contains(.game(.hockey)) {
            // TODO: User selected team
            // TODO: Current season
            let gamesFromAPI = await NHLAPI.schedule(useMockData: useMockData,
                                                     club: "NYR",
                                                     season: "20232024")?.games
            if let gamesFromAPI {
                for gameFromAPI in gamesFromAPI {
                    let adaptedGame = Game(gameID: gameFromAPI.id,
                                           homeTeam: gameFromAPI.homeTeam?.id ?? 0,
                                           homeTeamName: gameFromAPI.homeTeam?.abbrev ?? "",
                                           homeTeamCode: gameFromAPI.homeTeam?.abbrev ?? "",
                                           homePoints: gameFromAPI.homeTeam?.score ?? 0,
                                           awayTeam: gameFromAPI.awayTeam?.id ?? 0,
                                           awayTeamName: gameFromAPI.awayTeam?.abbrev ?? "",
                                           awayTeamCode: gameFromAPI.awayTeam?.abbrev ?? "",
                                           awayPoints: gameFromAPI.awayTeam?.score ?? 0,
                                           date: DateAdapter.dateFromAPI(date: gameFromAPI.startTimeUTC ?? ""),
                                           status: gameFromAPI.gameState ?? "",
                                           televisionOptions: gameFromAPI.tvBroadcasts?.first?.network ?? "",
                                           radioOptions: "",
                                           venue: "",
                                           type: .game(.hockey))
                    if adaptedGame.date > twoDaysAgo {
                        games.append(adaptedGame)
                    }
                }
            }
        }
        /// Basketball
        if sources.contains(.game(.basketball)) {
            let gamesFromAPI = await NBAAPI.games(useMockData: useMockData)?.data
            if let gamesFromAPI {
                for g in gamesFromAPI {
                    let adaptedGame = GameAdapter.getGameFrom(g)
                    if adaptedGame.date > twoDaysAgo {
                        games.append(adaptedGame)
                    }
                }
            }
        }
        let inAppGames = SampleManager.shared.localEvents
        for x in inAppGames {
            if x.date > Date.now {
                games.append(x)
            }
        }
        if loadLocalGames {
            let gamesFromStore = await StoreManager.shared.loadGames()
            games.append(contentsOf: gamesFromStore)
        }
        games.sort { lhs, rhs in
            lhs.date < rhs.date
        }
        logger.info("Games from user teams :- \(games.count)")
        return games
    }
    
    func save(_ games: [Game]) {
        let _ = Task {
            await StoreManager.shared.save(games: games)
        }
    }
}
