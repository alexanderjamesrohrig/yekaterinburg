//
//  MLBAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation
import OSLog

fileprivate let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "MLB")

struct MLB {
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
        let url = URL(string: MLB.baseURL + gamesURL)
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    private init() {}
}
