//
//  ContentModel.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import Foundation

@available(*, deprecated)
struct TeamResponse: Codable {
    let copyright: String
    let teams: [TeamResponseTeam]
}

@available(*, deprecated)
struct TeamResponseTeam: Codable {
    let id: Int
    let clubName: String
    let parentOrgName: String
    let locationName: String
}

class ContentModel: ObservableObject {
    
    private let baseURL = "https://statsapi.mlb.com/api/v1/"
    private let season = 2023
    private let dateFormatterResponse = DateFormatter()
    private let dateFormatterUser = DateFormatter()
    private let dateFormatterToday = DateFormatter()
    
    @available(*, deprecated, message: "Use DateAdapter.dateForAPI()")
    func getTodayInAPIFormat() -> String {
        dateFormatterToday.dateFormat = "yyyy-MM-dd"
        dateFormatterToday.timeZone = .autoupdatingCurrent
        let today = Date.now
        return dateFormatterToday.string(from: today)
    }
    
    @available(*, deprecated, message: "Use DateAdapter.timeFrom()")
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
        return dateFormatterUser.string(from: toDate ?? Date.now)
    }
    
    @available(*, deprecated, message: "Use Game.gamesFor()")
    func getGamesFor(date: String, team: Int) async throws -> Response {
        // 2023-06-29
        let url = URL(string: baseURL + "schedule?sportId=1&teamId=\(team)&date=\(date)&season=\(season)&hydrate=team,game(content(media(epg)))")!
//        let url = Bundle.main.url(forResource: "TEST", withExtension: "json") // LOCAL TEST.json
//        print(url ?? "")
        let (data, _) = try await URLSession.shared.data(from: url)
//        let data = try Data(contentsOf: url!) // LOCAL TEST.json
        let decoded = try JSONDecoder().decode(Response.self, from: data)
//        print(decoded)
        return decoded
    }
    
    @available(*, deprecated, message: "Use Game.allFor()")
    func getSeasonScheduleFor(season: String, team: Int) async throws -> Response {
//        let url = URL(string: baseURL + "schedule?sportId=1&teamId=117&season=2023&hydrate=team,game(content(media(epg)))")!
        let url = Bundle.main.url(forResource: "SCHEDULE", withExtension: "json") // LOCAL SCHEDULE.json
//        let (data, _) = try await URLSession.shared.data(from: url)
        let data = try Data(contentsOf: url!) // LOCAL SCHEDULE.json
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        print(decoded)
        return decoded
    }
    
    @available(*, deprecated, message: "Use Team.all")
    func getIDForTeams() async throws -> TeamResponse {
        let url = URL(string: baseURL + "teams")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(TeamResponse.self, from: data)
        return decoded
    }
}
