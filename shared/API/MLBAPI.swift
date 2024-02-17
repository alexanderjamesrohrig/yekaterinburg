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
    /// <#Description#>
    /// - Parameters:
    ///   - teamID: <#teamID description#>
    ///   - date: <#date description#>
    /// - Returns: <#description#>
    static func schedule(teamID: Int = 117, date: String) async throws -> Response {
        let url = URL(string: baseURL + "schedule?sportId=1&teamId=\(teamID)&date=\(date)&season=\(DateAdapter.yearFrom())&hydrate=team,game(content(media(epg)))")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        return decoded
    }
    /// <#Description#>
    /// - Parameter team: <#team description#>
    /// - Returns: <#description#>
    static func gamesFor(team: Int = 117) async -> Response? {
        let gamesURL = "schedule?sportId=1&teamId=\(team)&season=\(DateAdapter.yearFrom())&hydrate=team"
        let url = URL(string: MLBAPI.baseURL + gamesURL)
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    static func games(teamID: Int = 117, useMockData: Bool = false) async -> BaseballResponse? {
        guard var url = URL(string: "https://statsapi.mlb.com/api/v1/schedule") else {
            logger.error("Unable to create URL")
            return nil
        }
        let urlParameters = [
            URLQueryItem(name: "sportId", value: "1"),
            URLQueryItem(name: "teamId", value: "\(teamID)"),
            URLQueryItem(name: "season", value: "2024"),
        ]
        url = url.appending(queryItems: urlParameters)
        let mockURL = Bundle.main.url(forResource: "statsapi", withExtension: "json")
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
            let decoded = try decoder.decode(BaseballResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    private init() {}
}
