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
    
    static func channelsString(from response: [NBAChannelsResponse.NBAGameStream]?) -> String {
        guard let response else {
            return ""
        }
        var returnString = ""
        let lastIndex = response.count - 1
        for i in 0 ..< response.count {
            returnString.append(response[i].uniqueName ?? "")
            if i != lastIndex {
                returnString.append(SM.shared.or)
            }
        }
        return returnString
    }
    
    private init() {}
}
