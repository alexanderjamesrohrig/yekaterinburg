//
//  BaseballResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/17/24.
//

import Foundation

struct BaseballResponse: Codable {
    let copyright: String?
    let totalGames: Int?
    let dates: [MLBDate]
    
    struct GameContent: Codable {
        let media: GameMedia?
    }
    
    struct GameMedia: Codable {
        let epg: [GameEPG]?
        let freeGame: Bool?
    }
    
    struct GameEPG: Codable {
        let title: String?
        let items: [GameEPGItem]?
    }
    
    struct GameEPGItem: Codable {
        let callLetters: String?
    }
    
    struct MLBDate: Codable {
        let date: String
        let games: [MLBGame]
        
        struct MLBGame: Codable {
            let gamePk: Int
            let gameDate: Date
            let status: MLBStatus
            let teams: Teams
            let content: GameContent?
            
            struct MLBStatus: Codable {
                let detailedState: String
            }
            struct Teams: Codable {
                let home: Side
                let away: Side
                
                struct Side: Codable {
                    let team: Team
                    
                    struct Team: Codable {
                        let id: Int
                        let name: String
                    }
                }
            }
        }
    }
}
