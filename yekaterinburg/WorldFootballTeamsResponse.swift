//
//  WorldFootballTeamsResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/23/24.
//

import Foundation

struct WorldFootballTeamsResponse: Codable {
    let count: Int?
    let teams: [Team]?
    
    struct Team: Codable, Identifiable {
        let id: Int
        let name: String?
        let founded: Int?
        let venue: String?
        let lastUpdated: String?
    }
}
