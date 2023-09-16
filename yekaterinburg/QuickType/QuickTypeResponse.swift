import Foundation

struct Response: Codable {
    let copyright: String
    //let totalGames: Int
    let dates: [ResponseDate]
}

struct ResponseDate: Codable, Hashable {
    
    static func == (lhs: ResponseDate, rhs: ResponseDate) -> Bool {
        return lhs.date == rhs.date
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
        //hasher.combine(totalGames)
        hasher.combine(games)
    }
    
//    var id: UUID = UUID()
    let date: String
    //let totalGames: String
    let games: [ResponseDateGame]
}

struct ResponseDateGame: Codable, Hashable {
    static func == (lhs: ResponseDateGame, rhs: ResponseDateGame) -> Bool {
        return lhs.gamePk == rhs.gamePk
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(gamePk)
    }
    
    let gamePk: Int
    let gameDate: String
    let officialDate: String
    let status: ResponseDateGameStatus
    let teams: ResponseDateGameTeams
    let seriesDescription: String
//    let content: ResponseDateGameContent?
}

struct ResponseDateGameStatus: Codable {
    let abstractGameState: String
    let detailedState: String
    let statusCode: String
}

struct ResponseDateGameTeams: Codable {
    let away: ResponseDateGameTeamsSide
    let home: ResponseDateGameTeamsSide
}

struct ResponseDateGameTeamsSide: Codable {
    //let score: Int
    let team: ResponseDateGameTeam
}

struct ResponseDateGameTeam: Codable {
    let id: Int
    let teamCode: String
    let teamName: String
    let locationName: String
    let franchiseName: String
}

struct ResponseDateGameContent: Codable {
    let media: ResponseDateGameMedia
}
struct ResponseDateGameMedia: Codable {
    let epg: [ResponseDateGameMediaEPG]
}
struct ResponseDateGameMediaEPG: Codable {
    let title: String
    let items: [ResponseDateGameMediaEPGItem]
}
struct ResponseDateGameMediaEPGItem: Codable {
    let callLetters: String?
}
