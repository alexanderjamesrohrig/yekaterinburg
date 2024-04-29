//
//  MLBAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation
import OSLog

fileprivate let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "MLB")

struct MLBAPI {
    static let baseURL = "https://statsapi.mlb.com/api/v1/"
    
    /// MLB Stats API version 1 schedule
    /// - Parameters:
    ///   - useMockData: If local JSON file should be used instead of making network call, defaults to false
    ///   - season: Int year of season, Ex: 2024
    ///   - teamID: Int id of team to get schedule for
    /// - Returns: Optional BaseballResponse
    static func games(useMockData: Bool = false, season: Int, teamIDs: Int...) async -> BaseballResponse? {
        guard var url = URL(string: "https://statsapi.mlb.com/api/v1/schedule"),
              !teamIDs.isEmpty else {
            logger.error("Unable to create URL")
            return nil
        }
        let mergedIDs = teamIDs.map{ String($0) }.joined(separator: ",")
        logger.debug("\(mergedIDs)")
        let urlParameters = [
            URLQueryItem(name: "sportId", value: "1"),
            URLQueryItem(name: "teamId", value: mergedIDs),
            URLQueryItem(name: "season", value: "\(season)"),
            URLQueryItem(name: "hydrate", value: "game(content(media(epg)))")
        ]
        url = url.appending(queryItems: urlParameters)
        let mockURL = Bundle.main.url(forResource: "statsapi", withExtension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                let request = URLRequest(url: url)
                let (baseballData, _) = try await URLSession.shared.data(for: request)
                data = baseballData
            }
            let decoded = try decoder.decode(BaseballResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    /// MLB Stats API version 1 teams
    /// - Parameter useMockData: If local JSON file should be used instead of making network call, defaults to false
    /// - Returns: Optional QuickTypeTeams
    static func teams(useMockData: Bool = false) async -> QuickTypeTeams? {
        guard let url = URL(string: "https://statsapi.mlb.com/api/v1/teams") else {
            logger.error("Unable to create URL")
            return nil
        }
        let mockURL = Bundle.main.url(forResource: "Team", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                var request = URLRequest(url: url)
                request.cachePolicy = .returnCacheDataElseLoad
                let (baseballData, _) = try await URLSession.shared.data(for: request)
                data = baseballData
            }
            let decoded = try decoder.decode(QuickTypeTeams.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    private init() {}
}
