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
public struct Team: Identifiable, Codable {
    public var id = UUID()
    let sportSpecificID: Int
    let name: String
    let parentOrgName: String
    let sport: YeType
    var favorite: Bool = false
    
    static var all: [Team] {
        get async {
            var teams: [Team] = []
            if FeatureFlagManager.shared.ff1.enabled {
                logger.info("Teams from all sources")
                if let mlbTeams = await MLBAPI.teams(useMockData: true) {
                    logger.info("\(mlbTeams.teams.count) MLB teams")
                    teams.append(contentsOf: TeamAdapter.getTeamsFromMLB(mlbTeams))
                }
                if FFM.shared.ff5.enabled, let nbaTeams = await NBAAPI.teams() {
                    logger.info("\(nbaTeams.data.count) NBA teams")
                    teams.append(contentsOf: TeamAdapter.getTeamsFromNBA(nbaTeams))
                }
                if FFM.shared.ff4.enabled, let nhlTeams = await NHLAPI.teams() {
                    let teamsAdapted = TeamAdapter.getTeamsFromNHL(nhlTeams)
                    logger.info("\(teamsAdapted.count) NHL teams")
                    teams.append(contentsOf: teamsAdapted)
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
    
    /// Initialize Team object with response from MLB API
    /// - Parameter quickType: Object representing team from MLB API
    init(quickType: TeamElement) {
        self.sportSpecificID = quickType.id
        self.name = quickType.name
        self.parentOrgName = quickType.parentOrgName ?? ""
        self.sport = .game(.baseball)
    }
    init(id: Int, name: String, parentOrgName: String = "", sport: YeType) {
        self.sportSpecificID = id
        self.name = name
        self.parentOrgName = parentOrgName
        self.sport = sport
    }
}
