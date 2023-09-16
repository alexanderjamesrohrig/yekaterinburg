//
//  Team.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 9/14/23.
//

/*
 TODO
 Adapter class to translate QuickTypeTeam -> Team
 Return [Team]
 */

import Foundation

struct Team {
    
    let id: Int
    let name: String
    let parentOrgName: String
    
    static var all: [Team] { get async {
        var teams: [Team] = []
//        let url = URL(string: "https://statsapi.mlb.com/api/v1/teams")! // TODO connect to API
        let url = Bundle.main.url(forResource: "Team", withExtension: "json") // LOCAL JSON FILE
        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
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
    } }
    
    init(quickType: TeamElement) {
        self.id = quickType.id
        self.name = quickType.name
        self.parentOrgName = quickType.parentOrgName ?? ""
    }
}
