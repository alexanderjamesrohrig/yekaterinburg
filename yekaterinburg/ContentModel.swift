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

struct TeamResponse: Codable {
    let copyright: String
    let teams: [TeamResponseTeam]
}

struct TeamResponseTeam: Codable {
    let id: Int
    let clubName: String
    let parentOrgName: String
    let locationName: String
}

class ContentModel: ObservableObject {
    
    let baseURL = "https://statsapi.mlb.com/api/v1/"
    let season = 2023
    let dateFormatterResponse = DateFormatter()
    let dateFormatterUser = DateFormatter()
    let dateFormatterToday = DateFormatter()
    
    func getTodayInAPIFormat() -> String {
        dateFormatterToday.dateFormat = "yyyy-MM-dd"
        dateFormatterToday.timeZone = .autoupdatingCurrent
        let today = Date()
        return dateFormatterToday.string(from: today)
    }
    
    func getStringFrom(date: String) -> String {
//        print(date)
        // 2023-07-01T00:05:00Z
        dateFormatterResponse.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatterResponse.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let toDate = dateFormatterResponse.date(from: date)
//        print(toDate)
        dateFormatterUser.timeStyle = .short
        dateFormatterUser.dateStyle = .medium
        dateFormatterUser.timeZone = .autoupdatingCurrent
        return dateFormatterUser.string(from: toDate ?? Date())
    }
    
    func getGamesFor(date: String, team: Int) async throws -> Response {
        // 2023-06-29
        let url = URL(string: baseURL + "schedule?sportId=1&teamId=\(team)&date=\(date)&season=\(season)&hydrate=team")!
//        let url = Bundle.main.url(forResource: "TEST", withExtension: "json") // LOCAL TEST.json
//        print(url ?? "")
        let (data, _) = try await URLSession.shared.data(from: url)
//        let data = try Data(contentsOf: url!) // LOCAL TEST.json
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        //print(decoded)
        return decoded
    }
    
    func getIDForTeams() async throws -> TeamResponse {
        let url = URL(string: baseURL + "teams")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(TeamResponse.self, from: data)
        return decoded
    }
    
}
