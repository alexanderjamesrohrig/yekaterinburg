//
//  TeamAdapter.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/21/24.
//

import Foundation

struct TeamAdapter {
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
}
