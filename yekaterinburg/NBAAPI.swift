//
//  NBAAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/23/23.
//

import Foundation
import OSLog

fileprivate let logger = Logger(subsystem: GeneralSecretary.shared.subsystem,
                                category: "NBAAPI")

/// https://docs.balldontlie.io
struct NBAAPI {
    private typealias API = NBAAPI
    enum ResultSets: Int, RawRepresentable {
        case gameHeader = 0
        case lineScore = 1
    }
    enum GameHeaderKey: Int, RawRepresentable {
        case gameDateEST = 0
        case gameSequence = 1
        case gameID = 2
        case gameStatusID = 3
        case gameStatusText = 4
        case gameCode = 5
        case homeTeamID = 6
        case visitorTeamID = 7
        case season = 8
        case livePeriod = 9
        case livePCTime = 10
        case nationalTVBroadcaster = 11
        case homeTVBroadcaster = 12
        case awayTVBroadcaster = 13
        case livePeriodTimeBroadcase = 14
        case arenaName = 15
        case whStatus = 16
        case wnbaCommissionerFlag = 17
    }
    enum LineScoreKey: Int, RawRepresentable {
        case gameDateEST = 0
        case gameSequence = 1
        case gameID = 2
        case teamID = 3
        case teamAbbreviation = 4
        case teamCityName = 5
        case teamName = 6
        // TODO: Add others
    }
    static let refererHeaderKey = "Referer"
    static let pragmaHeaderKey = "Pragma"
    static let cacheHeaderKey = "Cache-Control"
    static let languageHeaderKey = "Accept-Language"
    static let tokenHeaderKey = "x-nba-stats-token"
    static let originHeaderKey = "x-nba-stats-origin"
    static let agentHeaderKey = "User-Agent"
    static let acceptHeaderKey = "Accept"
    static let refererValue = "https://stats.nba.com/"
    static let pragmaValue = "no-cache"
    static let cacheValue = "no-cache"
    static let languageValue = "en-US,en"
    static let tokenValue = "true"
    static let originValue = "stats"
    static let agentValue = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0"
    static let acceptValue = "application/json"
    
    /// <#Description#>
    /// - Parameter useMockData: If local JSON file should be used instead of making network call, defaults to false
    /// - Returns: Optional object from API
    static func teams(useMockData: Bool = false) async -> BasketballTeamsResponse? {
        guard let url = URL(string: "https://api.balldontlie.io/v1/teams") else {
            logger.error("Unable to create URL")
            return nil
        }
        logger.info("\(url)")
        let mockURL = Bundle.main.url(forResource: "teams", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                var request = URLRequest(url: url)
                request.addValue(StateSecretManager.shared.ballDontLieToken, forHTTPHeaderField: "Authorization")
                let (nbaData, response) = try await URLSession.shared.data(for: request)
                if let response = response as? HTTPURLResponse {
                    logger.info("\(response.statusCode) - \(url)")
                }
                data = nbaData
            }
            let decoded = try decoder.decode(BasketballTeamsResponse.self, from: data)
            logger.info("Teams :- \(decoded.data.count)")
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    
    /// Gets next 7 games in specified season for specified team.
    /// - Parameter useMockData: If local JSON file should be used instead of making network call, defaults to false
    /// - Returns: Optional object from API
    static func games(useMockData: Bool = false, teamIDs: [Int]) async -> BasketballResponse? {
        guard var url = URL(string: "https://api.balldontlie.io/v1/games") else {
            logger.error("Unable to create URL")
            return nil
        }
        var urlParameters = [
            URLQueryItem(name: "seasons[]", value: "2023"),
//            URLQueryItem(name: "team_ids[]", value: "\(userTeam)"),
            URLQueryItem(name: "per_page", value: "7"),
            URLQueryItem(name: "start_date", value: "\(DateAdapter.dateForAPI(date: Date.now))"),
        ]
        for id in teamIDs {
            let item = URLQueryItem(name: "team_ids[]", value: "\(id)")
            urlParameters.append(item)
        }
        url = url.appending(queryItems: urlParameters)
        let mockURL = Bundle.main.url(forResource: "balldontlie", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                var request = URLRequest(url: url)
                request.addValue(StateSecretManager.shared.ballDontLieToken, forHTTPHeaderField: "Authorization")
                let (nbaData, _) = try await URLSession.shared.data(for: request)
                data = nbaData
            }
            let decoded = try decoder.decode(BasketballResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    
    static func channels(useMockData: Bool = false) async -> NBAChannelsResponse? {
        // TODO: Add channels API call
        guard let url = URL(string: "https://cdn.nba.com/static/json/liveData/channels/v2/channels_00.json") else {
            logger.error("Unable to create URL")
            return nil
        }
        let mockURL = Bundle.main.url(forResource: "NBAChannels", withExtension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                let request = URLRequest(url: url)
                let (channelData, _) = try await URLSession.shared.data(for: request)
                data = channelData
            }
            let decoded = try decoder.decode(NBAChannelsResponse.self, from: data)
            logger.debug("Found \(decoded.channels?.games?.count ?? 0) games")
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    
    static func scoreboardV2(useMockData: Bool = true) async -> ScoreboardV2? {
        guard var url = URL(string: "https://stats.nba.com/stats/scoreboardv2") else {
            logger.error("Unable to create URL")
            return nil
        }
        var urlParameters = [
            URLQueryItem(name: "GameDate", value: DateAdapter.dateForAPI(date: Date.now)),
            URLQueryItem(name: "LeagueID", value: "00"),
        ]
        // TODO: Specific teams
//        for id in teamIDs {
//            let item = URLQueryItem(name: "team_ids[]", value: "\(id)")
//            urlParameters.append(item)
//        }
        url = url.appending(queryItems: urlParameters)
        let mockURL = Bundle.main.url(forResource: "NBAScoreboardV2", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                var request = URLRequest(url: url)
                request.addValue(API.refererValue, forHTTPHeaderField: API.refererHeaderKey)
                request.addValue(API.pragmaValue, forHTTPHeaderField: API.pragmaHeaderKey)
                request.addValue(API.cacheValue, forHTTPHeaderField: API.cacheHeaderKey)
                request.addValue(API.acceptValue, forHTTPHeaderField: API.acceptHeaderKey)
                request.addValue(API.tokenValue, forHTTPHeaderField: API.tokenHeaderKey)
                request.addValue(API.originValue, forHTTPHeaderField: API.originHeaderKey)
                request.addValue(API.agentValue, forHTTPHeaderField: API.agentHeaderKey)
                let (nbaData, _) = try await URLSession.shared.data(for: request)
                data = nbaData
            }
            let decoded = try decoder.decode(ScoreboardV2.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    
    static func channelsString(from response: [NBAChannelsResponse.NBAGameStream]?) -> String {
        guard let response else {
            return ""
        }
        let channel = response.first(where: { $0.rank == 0 })
        let returnString = NBAAPI.channelName(from: channel?.uniqueName)
        return returnString
    }
    
    static func channelName(from uniqueName: String?) -> String {
        switch uniqueName {
        case "NSS-ESPN":
            return "ESPN"
        case "NSS-ABC":
            return "ABC"
        case "NSS-TNT":
            return "TNT"
        default:
            return ""
        }
    }
    
    
    
    private init() {}
}
