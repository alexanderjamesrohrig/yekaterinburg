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
        let startTimeUTC: Date?
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
        let placeName: TeamPlace?
        let abbrev: String?
        let score: Int?
    }
    
    struct TeamPlace: Codable {
        let en: String?
        let fr: String?
        
        enum CodingKeys: String, CodingKey {
            case en = "default"
            case fr
        }
    }
}
