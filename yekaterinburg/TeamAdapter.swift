//
//  TeamAdapter.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/21/24.
//

import Foundation
import OSLog

struct TeamAdapter {
    private static let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "TeamAdapter")
    
    /// <#Description#>
    /// - Parameter teams: <#teams description#>
    /// - Returns: <#description#>
    static func getTeamsFromMLB(_ teams: QuickTypeTeams) -> [Team] {
        var list = [Team]()
        for x in teams.teams {
            let teamToAdd = Team(id: x.id,
                                 name: x.name,
                                 parentOrgName: x.parentOrgName ?? "",
                                 sport: .game(.baseball))
            list.append(teamToAdd)
        }
        return list
    }
    /// <#Description#>
    /// - Parameter teams: <#teams description#>
    /// - Returns: <#description#>
    static func getTeamsFromNBA(_ teams: BasketballTeamsResponse) -> [Team] {
        var list = [Team]()
        for x in teams.data {
            let teamToAdd = Team(id: x.id,
                                 name: x.name ?? "",
                                 parentOrgName: "",
                                 sport: .game(.basketball))
            list.append(teamToAdd)
        }
        return list
    }
    /// NHL response to team array adapter
    /// - Parameter teams: HockeyFranchiseResponse from API
    /// - Returns: Array of Team
    static func getTeamsFromNHL(_ teams: HockeyFranchiseResponse) -> [Team] {
        var list: [Team] = []
        guard let teamsData = teams.data else {
            logger.error("Franchises data is nil")
            return []
        }
        for x in teamsData {
            let teamToAdd = Team(id: x.id,
                                 name: x.fullName ?? "",
                                 sport: .game(.hockey))
            list.append(teamToAdd)
        }
        return list
    }
}
