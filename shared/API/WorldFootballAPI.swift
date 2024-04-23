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
    /// Gets all matches for specific team
    /// - Parameters:
    ///   - teamID: Team id on football-data.org
    ///   - useMockData: If local JSON file should be used instead of making network call, defaults to false
    /// - Returns: WorldFootballResponse object
    static func games(useMockData: Bool = false) async -> WorldFootballResponse? {
        let userTeam = UserDefaults.standard.integer(forKey: StoreManager.shared.appStorageCalcio)
        guard let url = URL(string: "http://api.football-data.org/v4/teams/\(userTeam)/matches") else {
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
    
    static func competitions(useMockData: Bool = false) async -> WorldFootballCompetitionsResponse? {
        guard let url = URL(string: "http://api.football-data.org/v4/competitions") else {
            logger.error("Unable to create URL")
            return nil
        }
        let mockURL = Bundle.main.url(forResource: "football-data_competitions", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                var request = URLRequest(url: url)
                request.addValue(StateSecretManager.shared.footballDataToken, forHTTPHeaderField: "X-Auth-Token")
                print(request)
                let (soccerData, _) = try await URLSession.shared.data(for: request)
                data = soccerData
            }
            let decoded = try decoder.decode(WorldFootballCompetitionsResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    
    static func teams(offset: Int = 0, useMockData: Bool = false) async -> WorldFootballTeamsResponse? {
        guard let url = URL(string: "http://api.football-data.org/v4/teams") else {
            logger.error("Unable to create URL")
            return nil
        }
        let mockURL = Bundle.main.url(forResource: "football-data_teams", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                var request = URLRequest(url: url)
                request.addValue(StateSecretManager.shared.footballDataToken, forHTTPHeaderField: "X-Auth-Token")
                print(request)
                let (soccerData, _) = try await URLSession.shared.data(for: request)
                data = soccerData
            }
            let decoded = try decoder.decode(WorldFootballTeamsResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    
    private init() {}
}
