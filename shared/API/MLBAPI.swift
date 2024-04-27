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
    ///   - teamID: Int id of team to get schedule for
    ///   - useMockData: If local JSON file should be used instead of making network call, defaults to false
    /// - Returns: Optional BaseballResponse
    static func games(useMockData: Bool = false) async -> BaseballResponse? {
        let userTeam = UserDefaults.standard.integer(forKey: StoreManager.shared.appStorageBaseball)
        guard var url = URL(string: "https://statsapi.mlb.com/api/v1/schedule") else {
            logger.error("Unable to create URL")
            return nil
        }
        let urlParameters = [
            URLQueryItem(name: "sportId", value: "1"),
            URLQueryItem(name: "teamId", value: "\(userTeam)"),
            URLQueryItem(name: "season", value: "2024"),
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
                let request = URLRequest(url: url)
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
