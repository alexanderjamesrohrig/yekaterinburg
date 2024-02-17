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
            guard let gamesFromAPI = await WorldFootballAPI.games(teamID: 113, useMockData: useMockData)?.matches else {
                logger.error("Unable to get soccer games")
                return []
            }
            for g in gamesFromAPI {
                let adaptedGame = GameAdapter.getGameFrom(footballGame: g)
                if adaptedGame.date > Date.now {
                    games.append(adaptedGame)
                }
            }
        }
        /// Baseball
        if sources.contains(.game(.baseball)) {
            guard let datesAndGamesFromAPI = await MLBAPI.games(teamID: 117, useMockData: useMockData) else {
                logger.error("Unable to get baseball games")
                return []
            }
            for d in datesAndGamesFromAPI.dates {
                for g in d.games {
                    let adaptedGame = GameAdapter.getGameFrom(baseballGame: g)
                    if adaptedGame.date > Date.now {
                        games.append(adaptedGame)
                    }
                }
            }
        }
        /// Professional Football
        /// https://plaintextsports.com/nfl/2023/schedule
        /// College Football
        ///
        if sources.contains(.game(.collegeFootball)) {
            // TODO: NCAA
        }
        /// Hockey
        /// https://plaintextsports.com/nhl/2023-2024/schedule
        if sources.contains(.game(.hockey)) {
            // TODO: NHL
        }
        /// Basketball
        if sources.contains(.game(.basketball)) {
            guard let gamesFromAPI = await NBAAPI.games(useMockData: useMockData)?.data else {
                logger.error("Unable to get basketball games")
                return []
            }
            for g in gamesFromAPI {
                if g.status != "Final" {
                    let adaptedGame = GameAdapter.getGameFrom(g)
                    if adaptedGame.date > Date.now {
                        games.append(adaptedGame)
                    }
                }
            }
        }
        if loadLocalGames {
            let gamesFromStore = await StoreManager.shared.loadGames()
            games.append(contentsOf: gamesFromStore)
        }
        games.sort { lhs, rhs in
            lhs.date < rhs.date
        }
        logger.info("\(#function) -> \(games.count)")
        return games
    }
    func save(_ games: [Game]) {
        let _ = Task {
            await StoreManager.shared.save(games: games)
        }
    }
}
