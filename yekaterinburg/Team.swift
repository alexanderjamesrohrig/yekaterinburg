//
//  Team.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/14/23.
//

import Foundation
import OSLog

fileprivate let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "Team")

public typealias Teams = [Team]
public struct Team: Identifiable, Codable, Hashable, Equatable {
    public let id: String
    let sportSpecificID: Int
    let name: String
    let code: String?
    let parentOrgName: String
    let sport: YeType
    var favorite: Bool = false
    
    static var all: [Team] {
        get async {
            var teams: [Team] = []
            let favorites = StoreManager.shared.loadFavorite()
            // FIXME: Do not add teams from APIs if they already exist as favorites
            teams.append(contentsOf: favorites)
            if FeatureFlagManager.shared.ff1.enabled {
                logger.info("Teams from all sources")
                if let mlbTeams = await MLBAPI.teams(useMockData: true) {
                    logger.info("\(mlbTeams.teams.count) MLB teams")
                    let teamsAdapted = TeamAdapter.getTeamsFromMLB(mlbTeams)
                    for tA in teamsAdapted {
                        if !favorites.contains(where: { $0.id == tA.id }) {
                            teams.append(tA)
                        }
                    }
                }
                if FFM.shared.ff5.enabled, let nbaTeams = await NBAAPI.teams() {
                    logger.info("\(nbaTeams.data.count) NBA teams")
                    let teamsAdapted = TeamAdapter.getTeamsFromNBA(nbaTeams)
                    for tA in teamsAdapted {
                        if !favorites.contains(where: { $0.id == tA.id }) {
                            teams.append(tA)
                        }
                    }
                }
                if FFM.shared.ff4.enabled, let nhlTeams = await NHLAPI.teams() {
                    let teamsAdapted = TeamAdapter.getTeamsFromNHL(nhlTeams)
                    logger.info("\(teamsAdapted.count) NHL teams")
                    for tA in teamsAdapted {
                        if !favorites.contains(where: { $0.id == tA.id }) {
                            teams.append(tA)
                        }
                    }
                }
                return teams
            } else {
                let url = Bundle.main.url(forResource: "Team", withExtension: "json")
                do {
                    let data = try Data(contentsOf: url!) // LOCAL JSON FILE
                    let decoded = try? JSONDecoder().decode(QuickTypeTeams.self, from: data)
                    logger.info("Teams :- \(decoded?.teams.count ?? 0)")
                    if let d = decoded {
                        for x in d.teams {
                            teams.append(Team(quickType: x))
                        }
                        teams.sort { (lhs, rhs) in
                            return lhs.id < rhs.id
                        }
                    }
                    return teams
                }
                catch {
                    print("Team.all error")
                    return teams
                }
            }
        }
    }
    
    public static func ==(lhs: Team, rhs: Team) -> Bool {
        lhs.id == rhs.id
    }
    
    static func nhlCode(from id: Int) -> String {
        // TODO: Finish codes
        switch id {
        case 1:
            return "MTL"
        case 5:
            return "TOR"
        case 6:
            return "BOS"
        case 10:
            return "NYR"
        case 11:
            return "CHI"
        case 12:
            return "DET"
        case 13:
            return "CLE"
        case 14:
            return "LAK"
        case 15:
            return "DAL"
        case 16:
            return "PHI"
        case 17:
            return "PIT"
        case 18:
            return "STL"
        case 19:
            return "BUF"
        case 20:
            return "VAN"
        case 21:
            return "CGY"
        case 22:
            return "NYI"
        case 23:
            return "NJD"
        case 24:
            return "WSH"
        case 25:
            return "EDM"
        case 26:
            return "CAR"
        case 27:
            return "COL"
        case 28:
            return "ARI" // TODO: Might change with new Utah club
        case 29:
            return "SJS"
        case 30:
            return "OTT"
        case 31:
            return "TBL"
        case 32:
            return "ANA"
        case 33:
            return "FLA"
        case 34:
            return "NSH"
        case 35:
            return "WPG"
        case 36:
            return "CBJ"
        case 37:
            return "MIN"
        case 38:
            return "VGK"
        case 39:
            return "SEA"
        default:
            return ""
        }
    }
    
    /// Initialize Team object with response from MLB API
    /// - Parameter quickType: Object representing team from MLB API
    init(quickType: TeamElement) {
        self.id = "\(YeType.game(.baseball).hashValue)_\(quickType.id)"
        self.sportSpecificID = quickType.id
        self.name = quickType.name
        self.parentOrgName = quickType.parentOrgName ?? ""
        self.sport = .game(.baseball)
        self.code = ""
    }
    
    /// Initialize Team object
    /// - Parameters:
    ///   - id: String sport specific ID that will be used to create unique team ID
    ///   - name: String name of team
    ///   - parentOrgName: String name of parent organization of team, defaults to empty
    ///   - sport: YeType of sport that team competes in
    ///   - code: String short name that could replace sport specific ID
    init(id: Int, name: String, parentOrgName: String = "", sport: YeType, code: String = "") {
        self.id = "\(sport.idPrefix)\(id)"
        self.sportSpecificID = id
        self.name = name
        self.parentOrgName = parentOrgName
        self.sport = sport
        self.code = code
    }
    
    /// Initialize Team for a hockey team and generate code
    /// - Parameters:
    ///   - id: String sport specific ID that will be used to create unique team ID and get team code
    ///   - name: String name of team
    ///   - parentOrgName: String name of parent organization of team, defaults to empty
    init(id: Int, name: String, parentOrgName: String = "") {
        self.id = "\(YeType.game(.hockey).idPrefix)\(id)"
        self.sportSpecificID = id
        self.name = name
        self.parentOrgName = parentOrgName
        self.sport = YeType.game(.hockey)
        self.code = Team.nhlCode(from: id)
    }
}
