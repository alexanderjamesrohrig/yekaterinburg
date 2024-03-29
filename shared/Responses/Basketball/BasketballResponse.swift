//
//  BasketballResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/23/23.
//

import Foundation

struct BasketballResponse: Codable {
    let data: [BBallGame]
    
    struct BBallGame: Codable, Identifiable {
        let id: Int
        let date: String?
        let home_team: BBTeam?
        let home_team_score: Int?
        let visitor_team: BBTeam?
        let visitor_team_score: Int?
        let status: String?

        struct BBTeam: Codable, Identifiable {
            let id: Int?
            let abbreviation: String?
            let city: String?
            let full_name: String?
        }
    }
}
