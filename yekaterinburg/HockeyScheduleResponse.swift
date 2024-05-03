//
//  nhle-schedule.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/26/24.
//

import Foundation

struct HockeyScheduleResponse: Codable {
    
    let games: [GameEvent]?
    
    struct GameEvent: Codable, Identifiable {
        let id: Int
        let gameDate: String?
        let startTimeUTC: String?
        let gameState: String?
        let tvBroadcasts: [Broadcast]?
        let awayTeam: GameEventTeam?
        let homeTeam: GameEventTeam?
    }
    
    struct Broadcast: Codable, Identifiable {
        let id: Int
        let network: String?
    }
    
    struct GameEventTeam: Codable {
        let id: Int
        let abbrev: String?
        let score: Int?
    }
}
