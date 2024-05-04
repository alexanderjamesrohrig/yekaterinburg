//
//  NBAChannelsResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 5/4/24.
//

import Foundation

struct NBAChannelsResponse: Codable {
    let channels: Channels?
    
    struct Channels: Codable {
        let lastUpdated: Date?
        let gameDate: String?
        let games: [NBAStaticGame]?
    }
    
    struct NBAStaticGame: Codable {
        let gameId: Int?
        let gameStatus: Int?
        let gameState: Int?
        let streams: [NBAGameStream]?
    }
    
    struct NBAGameStream: Codable {
        let rank: Int?
        let uniqueName: String?
        let inMarketTeamTricode: String?
        let inMarketTeamId: String?
    }
}
