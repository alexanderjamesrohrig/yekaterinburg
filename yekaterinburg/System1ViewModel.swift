//
//  System1ViewModel.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/12/24.
//

import Foundation
import OSLog

@MainActor class System1ViewModel: ObservableObject {
    enum State {
        case loading, error, noGames, success, unknown
    }
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "System1ViewModel")
    var twoDaysAgo: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: -2, to: Date.now) ?? Date.now
    }
    var nbaEnabled: Bool {
        let ff = FFM.shared.ff5.enabled
        let setting = UserDefaults.standard.bool(forKey: StoreManager.shared.appStorageShowNBAGames)
        logger.debug("NBA :- \(ff) && \(setting)")
        return ff && setting
    }
    var games: [Game] = []
    @Published var state: State = .unknown
    
    /// Returns array of Game objects from API and local sources
    /// - Parameter sources: Set of YeType, used to decide which APIs to fetch from.
    /// - Returns: Array of Game objects
    func getGamesFrom(sources: Set<YeType>,
                      useMockData: Bool = false,
                      includePastGames: Bool = false,
                      loadLocalGames: Bool = false) async -> [Game] {
        let favoriteTeams = StoreManager.shared.loadFavorite()
        // TODO: Helper functions
        // FIXME: Concurrent mutation of games
        var games: [Game] = []
        /// Calcio
        if sources.contains(.game(.calcio)) && FFM.shared.ff3.enabled {
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
            let favoriteBaseballTeams = favoriteTeams.filter({ $0.sport == .game(.baseball)}).map({ $0.sportSpecificID })
            if favoriteBaseballTeams.count > 0 {
                let datesAndGamesFromAPI = await MLBAPI.games(season: 2024, teamIDs: favoriteBaseballTeams)
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
        }
        /// Professional Football
        /// https://plaintextsports.com/nfl/2023/schedule
        /// College Football
        ///
//        if sources.contains(.game(.collegeFootball)) {
//            // TODO: NCAA
//        }
        /// Hockey
        if sources.contains(.game(.hockey)) && FFM.shared.ff4.enabled {
            // TODO: User selected team
            // TODO: Current season
            let favoriteHockeyTeams = favoriteTeams.filter({ $0.sport == .game(.hockey) }).map({ $0.code })
            let firstID = favoriteHockeyTeams.first ?? ""
            let firstIDUnwrapped = firstID ?? ""
            // FIXME: Unable to get more than 1 hockey club
            let gamesFromAPI = await NHLAPI.schedule(useMockData: useMockData,
                                                     club: firstIDUnwrapped,
                                                     season: "20232024")?.games
            if let gamesFromAPI {
                for gameFromAPI in gamesFromAPI {
                    var adaptedGame = Game()
                    if UserDefaults.standard.bool(forKey: StoreManager.shared.appStoragePreferFrench) {
                        adaptedGame = Game(gameID: gameFromAPI.id,
                                           homeTeam: gameFromAPI.homeTeam?.id ?? 0,
                                           homeTeamName: gameFromAPI.homeTeam?.placeName?.fr ?? gameFromAPI.homeTeam?.placeName?.en ?? "",
                                           homeTeamCode: gameFromAPI.homeTeam?.abbrev ?? "",
                                           homePoints: gameFromAPI.homeTeam?.score ?? 0,
                                           awayTeam: gameFromAPI.awayTeam?.id ?? 0,
                                           awayTeamName: gameFromAPI.awayTeam?.placeName?.fr ?? gameFromAPI.awayTeam?.placeName?.en ?? "",
                                           awayTeamCode: gameFromAPI.awayTeam?.abbrev ?? "",
                                           awayPoints: gameFromAPI.awayTeam?.score ?? 0,
                                           date: gameFromAPI.startTimeUTC ?? Date.distantPast,
                                           status: gameFromAPI.gameState ?? "",
                                           televisionOptions: GameAdapter.getNHLBroadcasts(gameFromAPI.tvBroadcasts),
                                           radioOptions: "",
                                           venue: "",
                                           type: .game(.hockey))
                    } else {
                        adaptedGame = Game(gameID: gameFromAPI.id,
                                           homeTeam: gameFromAPI.homeTeam?.id ?? 0,
                                           homeTeamName: gameFromAPI.homeTeam?.placeName?.en ?? "",
                                           homeTeamCode: gameFromAPI.homeTeam?.abbrev ?? "",
                                           homePoints: gameFromAPI.homeTeam?.score ?? 0,
                                           awayTeam: gameFromAPI.awayTeam?.id ?? 0,
                                           awayTeamName: gameFromAPI.awayTeam?.placeName?.en ?? "",
                                           awayTeamCode: gameFromAPI.awayTeam?.abbrev ?? "",
                                           awayPoints: gameFromAPI.awayTeam?.score ?? 0,
                                           date: gameFromAPI.startTimeUTC ?? Date.distantPast,
                                           status: gameFromAPI.gameState ?? "",
                                           televisionOptions: GameAdapter.getNHLBroadcasts(gameFromAPI.tvBroadcasts),
                                           radioOptions: "",
                                           venue: "",
                                           type: .game(.hockey))
                    }
                    if adaptedGame.date > twoDaysAgo {
                        games.append(adaptedGame)
                    }
                }
            }
        }
        /// Basketball
        if sources.contains(.game(.basketball)) && nbaEnabled {
            await games.append(contentsOf: nbaGamesToday())
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
        if games.isEmpty {
            state = .noGames
        } else {
            state = .success
        }
        return games
    }
    
    func nbaGamesToday() async -> [Game]{
        let response = await NBAAPI.scoreboardV2(useMockData: false)
        guard let response else {
            return []
        }
        return GameAdapter.games(from: response)
    }
    
    func save(_ games: [Game]) {
        let _ = Task {
            await StoreManager.shared.save(games: games)
        }
    }
}
