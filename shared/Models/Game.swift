//
//  Game.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/5/23.
//

import Foundation
import OSLog
import SwiftUI

fileprivate let logger = Logger(subsystem: "com.alexanderrohrig.yekaterinburg", category: "Game")

enum YeType: Hashable, Codable{
    case event
    case game(Game)
    
    enum Game: Codable {
        case baseball
        case collegeFootball
        case hockey
        case basketball
        case calcio
        case football
    }
}

struct Game: Identifiable, Codable {
    var id: Int
    var homeTeam: Int = 0
    var homeTeamName: String
    var homeTeamCode: String = ""
    var homePoints: Int = 0
    var awayTeam: Int = 0
    var awayTeamName: String = ""
    var awayTeamCode: String = ""
    var awayPoints: Int = 0
    var date: Date = Date.now
    var status: String = ""
    var televisionOptions: String = ""
    var radioOptions: String = ""
    var venue: String = ""
    var type: YeType
    
    // MARK: - Static constants
    static let supportedLeagues = ["Baseball",
                                   "Hockey",
                                   "College Football",]
    
    // MARK: - Static variables
    static var blank: Game {
        Game(homeName: "Home", awayName: "Away")
    }
    static var blankEvent: Game {
        Game(gameID: 0, homeTeamName: "Sample Event", status: "Scheduled", televisionOptions: "SAM", radioOptions: "SAMP", venue: "Sample Venue", type: .event)
    }
    
    // MARK: - Static functions
    static func games(for sport: YeType) -> [HockeyResponse.NHLDate] {
        let url = Bundle.main.url(forResource: "nhl-schedule", withExtension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let data = try Data(contentsOf: url!)
            let decoded = try decoder.decode(HockeyResponse.self, from: data)
            return decoded.dates
        } catch {
            return []
        }
    }
    
    static func gamesToday(for sport: YeType, date: String) -> [HockeyResponse.NHLDate.NHLGame] {
        let gamesToday = games(for: sport).filter { $0.date == date }
        if let g = gamesToday.first?.games {
            return g
        } else {
            return []
        }
    }
    
    static func gamesToday(for sport: YeType, date: String, team: Int) -> [HockeyResponse.NHLDate.NHLGame] {
        let gamesTodayForTeam = gamesToday(for: sport, date: date)
        var returnArray: [HockeyResponse.NHLDate.NHLGame] = []
        for x in gamesTodayForTeam {
            if x.teams.away.team.id == team || x.teams.home.team.id == team {
                returnArray.append(x)
            }
        }
        return returnArray
    }
    
    static func name(_ fromNHLTeamID: Int) -> String {
        switch fromNHLTeamID {
        case 1: "NJ"
        case 3: "NYR"
        case 4: "PHI"
        case 5: "PIT"
        case 13: "FLA"
        case 17: "DET"
        case 19: "STL"
        case 25: "DAL"
        case 28: "STL"
        case 53: "ARI"
        case 54: "LV"
        case 55: "SEA"
        default: "\(fromNHLTeamID)"
        }
    }
    
    @ViewBuilder static func name(_ fromCollegeFootballTeamID: Int, fallback: String = "") -> some View {
        switch fromCollegeFootballTeamID {
        case 87:
            Image("fbs-87")
        case 249:
            Text("UNT")
        default:
            Text(fallback)
        }
    }
    
    // MARK: - Initializers
    /// Initialize blank Game object
    init() {
        self.id = UUID().hashValue
        self.homeTeam = 586
        self.awayTeam = 2
        self.homePoints = 0
        self.awayPoints = 0
        self.homeTeamCode = "SI"
        self.awayTeamCode = "AWA"
        self.homeTeamName = "Staten Island Ferry Hawks"
        self.awayTeamName = "Away"
        self.date = Date.now
        self.status = "Blank"
        self.type = .event
    }
    
    /// Initialize Game object with team names only
    init(homeName: String, awayName: String) {
        self.id = UUID().hashValue
        self.homeTeam = 1
        self.awayTeam = 2
        self.homeTeamName = homeName
        self.awayTeamName = awayName
        self.type = .event
    }
    
    /// Initialize Game object from HockeyResponse.NHLDate.NHL.Game 🏒
    init(game: HockeyResponse.NHLDate.NHLGame) {
        self.id = game.gamePk
        self.homeTeam = game.teams.home.team.id
        self.homeTeamName = game.teams.home.team.name
        self.homeTeamCode = Game.name(game.teams.home.team.id)
        self.awayTeam = game.teams.away.team.id
        self.awayTeamName = game.teams.away.team.name
        self.awayTeamCode = Game.name(game.teams.away.team.id)
        self.date = game.gameDate
        self.status = game.status.detailedState
        self.homePoints = game.teams.home.score
        self.awayPoints = game.teams.away.score
        self.type = .game(.hockey)
        self.televisionOptions = ""
    }
    
    /// Initialize Game object from CollegeFootballGame 🏈
    init(game: CollegeFootballGame) {
        self.id = game.id
        self.homeTeam = game.home_id
        self.homeTeamName = game.home_team
        self.homeTeamCode = ""
        self.awayTeam = game.away_id
        self.awayTeamName = game.away_team
        self.awayTeamCode = ""
        self.date = game.start_date
        self.status = ""
        self.homePoints = game.home_points
        self.awayPoints = game.home_points
        self.type = .game(.collegeFootball)
        self.televisionOptions = ""
    }
    
    init(gameID: Int, homeTeam: Int = 0, homeTeamName: String, homeTeamCode: String = "", homePoints: Int = 0, awayTeam: Int = 0, awayTeamName: String = "", awayTeamCode: String = "", awayPoints: Int = 0, date: Date = Date.now, status: String = "", televisionOptions: String = "", radioOptions: String = "", venue: String = "", type: YeType) {
        self.id = gameID
        self.homeTeam = homeTeam
        self.homeTeamName = homeTeamName
        self.homeTeamCode = homeTeamCode
        self.homePoints = homePoints
        self.awayTeam = awayTeam
        self.awayTeamName = awayTeamName
        self.awayTeamCode = awayTeamCode
        self.awayPoints = awayPoints
        self.date = date
        self.status = status
        self.televisionOptions = televisionOptions
        self.radioOptions = radioOptions
        self.venue = venue
        self.type = type
    }
}
