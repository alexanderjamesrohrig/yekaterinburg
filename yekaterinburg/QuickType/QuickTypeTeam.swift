// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let team = try? JSONDecoder().decode(Team.self, from: jsonData)

import Foundation

// MARK: - Team
struct QuickTypeTeams: Codable {
    let copyright: String
    let teams: [TeamElement]
}

// MARK: - TeamElement
struct TeamElement: Codable {
    let allStarStatus: AllStarStatus
    let id: Int
    let name, link: String
    let season: Int
    let venue: Division
    let teamCode, fileCode: String
    let abbreviation: String?
    let teamName: String
    let locationName, firstYearOfPlay: String?
    let league: Division
    let division: Division?
    let sport: Division
    let shortName: String
    let parentOrgName: String?
    let parentOrgID: Int?
    let franchiseName, clubName: String?
    let active: Bool
    let springLeague: Division?
    let springVenue: SpringVenue?

    enum CodingKeys: String, CodingKey {
        case allStarStatus, id, name, link, season, venue, teamCode, fileCode, abbreviation, teamName, locationName, firstYearOfPlay, league, division, sport, shortName, parentOrgName
        case parentOrgID = "parentOrgId"
        case franchiseName, clubName, active, springLeague, springVenue
    }
}

enum AllStarStatus: String, Codable {
    case n = "N"
}

// MARK: - Division
struct Division: Codable {
    let id: Int?
    let name: String?
    let link: String
    let abbreviation: Abbreviation?
}

enum Abbreviation: String, Codable {
    case cl = "CL"
    case gl = "GL"
}

// MARK: - SpringVenue
struct SpringVenue: Codable {
    let id: Int
    let link: String
}
