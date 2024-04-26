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
    /// - Returns: HockeyFranchiseResponse struct
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
                data = try Data(contentsOf: mockURL!)
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
}
