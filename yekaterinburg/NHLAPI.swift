//
//  NHLAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/26/24.
//

import Foundation
import OSLog

/// API to access hockey data
///
/// Documentation:
/// https://github.com/Zmalski/NHL-API-Reference
///
struct NHLAPI {
    private static let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "NHLAPI")
    private init() {}
    
    /// Returns franchises of the National Hockey League
    /// - Parameter useMockData: Bool to use local JSON file as response
    /// - Returns: Optional HockeyFranchiseResponse
    static func teams(useMockData: Bool = false) async -> HockeyFranchiseResponse? {
        guard let url = URL(string: "https://api.nhle.com/stats/rest/en/franchise") else {
            Self.logger.error("Unable to create URL")
            return nil
        }
        let mockURL = Bundle.main.url(forResource: "nhle-franchise", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                guard let mockURL else {
                    logger.error("Unable to find mock file")
                    return nil
                }
                data = try Data(contentsOf: mockURL)
            } else {
                let request = URLRequest(url: url)
                let (responseData, _) = try await URLSession.shared.data(for: request)
                data = responseData
            }
            let decoded = try decoder.decode(HockeyFranchiseResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    
    /// Returns schedule for specific franchise
    /// - Parameters:
    ///   - useMockData: Bool to use local JSON file as response
    ///   - club: Team abbreviation, Ex: NYR
    ///   - season: Season in YYYYYYYY format, Ex: 20232024
    /// - Returns: Optional HockeyScheduleResponse
    static func schedule(useMockData: Bool = false,
                         club: String,
                         season: String) async -> HockeyScheduleResponse? {
        guard let url = URL(string: "https://api-web.nhle.com/v1/club-schedule-season/\(club)/\(season)") else {
            Self.logger.error("Unable to create URL")
            return nil
        }
        let mockURL = Bundle.main.url(forResource: "nhle-schedule", withExtension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            var data = Data()
            if useMockData {
                guard let mockURL else {
                    logger.error("Unable to find mock file")
                    return nil
                }
                data = try Data(contentsOf: mockURL)
            } else {
                let request = URLRequest(url: url)
                let (responseData, _) = try await URLSession.shared.data(for: request)
                data = responseData
            }
            let decoded = try decoder.decode(HockeyScheduleResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
}
