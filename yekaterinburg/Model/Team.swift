//
//  Team.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/14/23.
//

import Foundation
import OSLog

fileprivate let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "Team")

struct Team: Identifiable {
    let id: Int
    let name: String
    let parentOrgName: String
    let sport: YeType
    
    static var all: [Team] {
        get async {
            var teams: [Team] = []
            if FeatureFlagManager.shared.teamsFromAllAPISources {
                guard let mlbTeams = await MLBAPI.teams(useMockData: true) else {
                    logger.error("Unable to get MLB teams")
                    return []
                }
                logger.info("\(mlbTeams.teams) MLB teams")
                teams.append(contentsOf: TeamAdapter.getTeamsFromMLB(mlbTeams))
                guard let nbaTeams = await NBAAPI.teams(useMockData: true) else {
                    logger.error("Unable to get NBA teams")
                    return []
                }
                logger.info("\(nbaTeams.data.count) NBA teams")
                teams.append(contentsOf: TeamAdapter.getTeamsFromNBA(nbaTeams))
                return teams
            } else {
                let url = Bundle.main.url(forResource: "Team", withExtension: "json")
                do {
                    let data = try Data(contentsOf: url!) // LOCAL JSON FILE
                    let decoded = try? JSONDecoder().decode(QuickTypeTeams.self, from: data)
                    print(decoded ?? "")
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
        self.id = quickType.id
        self.name = quickType.name
        self.parentOrgName = quickType.parentOrgName ?? ""
        self.sport = .game(.baseball)
    }
    init(id: Int, name: String, parentOrgName: String, sport: YeType) {
        self.id = id
        self.name = name
        self.parentOrgName = parentOrgName
        self.sport = sport
    }
}
