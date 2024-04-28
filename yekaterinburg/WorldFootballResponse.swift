//
//  WorldFootballResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/17/24.
//

import Foundation

struct WorldFootballResponse: Codable {
    let matches: [Match]
    
    struct Match: Codable {
        let id: Int
        let status: String
        let utcDate: String
        let homeTeam: Team
        let awayTeam: Team
        
        struct Team: Codable {
            let id: Int
            let shortName: String
        }
    }
}
