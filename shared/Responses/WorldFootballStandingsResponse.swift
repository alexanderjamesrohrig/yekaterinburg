//
//  WorldFootballStandingsResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/25/24.
//

import Foundation

struct WorldFootballStandingsResponse: Codable {
    let competition: WorldFootballCompetitionsResponse.Competition?
    let season: Season?
    let standings: [Standing]?
    
    struct Season: Codable {
        let id: Int
        let startDate: String?
        let endDate: String?
        let currentMatchday: Int?
//        let winner: String? // TODO: Unknown type
    }
    
    struct Standing: Codable {
        let stage: String?
        let table: [TablePosition]?
    }
    
    struct TablePosition: Codable {
        let position: Int?
        let team: WorldFootballTeamsResponse.Team
        let playedGames: Int?
        let won: Int?
        let draw: Int?
        let lost: Int?
        let points: Int?
    }
}
