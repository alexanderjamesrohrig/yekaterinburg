//
//  MLBAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/16/23.
//

import Foundation

struct MLB {
    static let baseURL = "https://statsapi.mlb.com/api/v1/"
    
    static func schedule(teamID: Int = 117, date: String) async throws -> Response {
        let url = URL(string: baseURL + "schedule?sportId=1&teamId=\(teamID)&date=\(date)&season=\(DateAdapter.yearFrom())&hydrate=team,game(content(media(epg)))")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        return decoded
    }
}
