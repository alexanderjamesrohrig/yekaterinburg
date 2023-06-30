//
//  ContentModel.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import Foundation

//struct Response: Codable {
//    var copyright: String
//    var totalGames: Int
//    var dates: [ResponseDate]?
//}
//
//struct ResponseDate: Codable, Identifiable {
//    var id = UUID()
//    var date: String
//    var totalGames: Int
//    var games: [ResponseGame]?
//}
//
//struct ResponseGame: Codable, Identifiable {
//    var id = UUID()
//    var gamePk: Int
//    var gameDate: String
//}

class ContentModel: ObservableObject {
    
    let baseURL = "https://statsapi.mlb.com/api/v1/"
    let season = 2023
    
    func getGamesFor(date: String, team: Int) async throws -> Response {
        // 2023-06-29
//        let url = URL(string: baseURL + "schedule?sportId=1&teamId=\(team)&date=\(date)&season=\(season)&hydrate=team")!
        let url = Bundle.main.url(forResource: "TEST", withExtension: "json")
        print(url ?? "")
//        let (data, _) = try await URLSession.shared.data(from: url)
        let data = try Data(contentsOf: url!)
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        print(decoded)
        return decoded
    }
    
}
