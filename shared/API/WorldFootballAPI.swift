//
//  WorldFootballAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/17/24.
//

import Foundation
import OSLog

/// https://www.football-data.org/documentation/quickstart
private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "WorldFootballAPI")

struct WorldFootballAPI {
    static func games(teamID: Int = 113, useMockData: Bool = false) async -> WorldFootballResponse? {
        guard let url = URL(string: "http://api.football-data.org/v4/teams/\(teamID)/matches") else {
            logger.error("Unable to create URL")
            return nil
        }
        let mockURL = Bundle.main.url(forResource: "football-data", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                var request = URLRequest(url: url)
                request.addValue(StateSecretManager.shared.footballDataToken, forHTTPHeaderField: "X-Auth-Token")
                let (soccerData, _) = try await URLSession.shared.data(for: request)
                data = soccerData
            }
            let decoded = try decoder.decode(WorldFootballResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    private init() {}
}
