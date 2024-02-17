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
    /// - Parameter useMockData: <#useMockData description#>
    /// - Returns: <#description#>
    static func games(useMockData: Bool = false) async -> BasketballResponse? {
        guard var url = URL(string: "https://www.balldontlie.io/api/v1/games") else {
            return nil
        }
        let urlParameters = [
            URLQueryItem(name: "seasons", value: "\(DateAdapter.yearFrom())"),
            URLQueryItem(name: "team_ids", value: "20"),
            URLQueryItem(name: "per_page", value: "1"),
        ]
        url = url.appending(queryItems: urlParameters)
        let mockURL = Bundle.main.url(forResource: "balldontlie", withExtension: "json")
        let decoder = JSONDecoder()
        do {
            var data = Data()
            if useMockData {
                data = try Data(contentsOf: mockURL!)
            } else {
                let (data, _) = try await URLSession.shared.data(from: url)
                print(String(data: data, encoding: .utf8))
            }
            let decoded = try decoder.decode(BasketballResponse.self, from: data)
            return decoded
        } catch {
            logger.error("Unable to decode API data")
            return nil
        }
    }
    private init() {}
}
