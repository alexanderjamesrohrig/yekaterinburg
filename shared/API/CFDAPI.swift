//
//  CFDAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/20/23.
//

import Foundation

struct CFDAPI {
    static let baseURL = "https://api.collegefootballdata.com"
    static let headerAccept = "application/json"
    static let headerAuth = "Bearer ..."
    
    static func games(team: String = "North Texas") -> CollegeFootballResponse {
        let url = Bundle.main.url(forResource: "collegefootballdata-games", withExtension: "json")
        do {
            let data = try Data(contentsOf: url!)
            let decoded = try JSONDecoder().decode(CollegeFootballResponse.self, from: data)
            print(decoded)
            return decoded
        } catch {
            return []
        }
    }
    
    static func media(team: String = "North Texas") async throws -> CollegeFootballMediaResponse {
        let url = URL(string: "https://api.collegefootballdata.com/games/media?year=\(DateAdapter.yearFrom())&team=North%20Texas")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(CollegeFootballMediaResponse.self, from: data)
        return decoded
    }
}
