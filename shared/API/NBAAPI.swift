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
            logger.error("Unable to create URL")
            return nil
        }
        let urlParameters = [
            URLQueryItem(name: "seasons[]", value: "2023"),
            URLQueryItem(name: "team_ids[]", value: "20"),
            URLQueryItem(name: "per_page", value: "7"),
            URLQueryItem(name: "start_date", value: "\(DateAdapter.dateForAPI(date: Date.now))"),
        ]
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
    private init() {}
}
