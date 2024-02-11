//
//  NHLAPI.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/12/23.
//

import Foundation

struct HockeyResponse: Codable, Hashable {
    let copyright: String
    let dates: [NHLDate]
    
    struct NHLDate: Codable, Hashable {
        let date: String
        let totalGames: Int
        let games: [NHLGame]
        
        struct NHLGame: Codable, Hashable {
            static func == (lhs: HockeyResponse.NHLDate.NHLGame, rhs: HockeyResponse.NHLDate.NHLGame) -> Bool {
                lhs.gamePk == rhs.gamePk
            }
            
            let gamePk: Int
            let gameType: String
            let status: Status
            let teams: Teams
            let gameDate: Date // 2023-09-23T04:05:00Z
            
            struct Status: Codable, Hashable {
                let detailedState: String
            }
            struct Teams: Codable, Hashable {
                let away: NHLTeam
                let home: NHLTeam
                
                struct NHLTeam: Codable, Hashable {
                    let score: Int
                    let team: NHLTeamTeam
                    
                    struct NHLTeamTeam: Codable, Hashable {
                        let id: Int
                        let name: String
                    }
                }
            }
        }
    }
}
