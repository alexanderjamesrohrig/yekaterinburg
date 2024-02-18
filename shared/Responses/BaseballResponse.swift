//
//  BaseballResponse.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/17/24.
//

import Foundation

struct BaseballResponse: Codable {
    let copyright: String
    let dates: [MLBDate]
    
    struct MLBDate: Codable {
        let date: String
        let games: [MLBGame]
        
        struct MLBGame: Codable {
            let gamePk: Int
            let gameDate: String
            let status: MLBStatus
            let teams: Teams
            
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
