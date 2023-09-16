//
//  WidgetModel.swift
//  
//
//  Created by Alexander Rohrig on 7/14/23.
//

import Foundation
import WidgetKit

let sampleEntry: SimpleEntry = SimpleEntry(date: Date(),
                                           teamID: 117,
                                           isHome: false,
                                           opponentName: "Kansas City",
                                           gameDateTime: Date(timeIntervalSince1970: 1694905800))

let sampleGame: GameEntry = GameEntry(date: Date(timeIntervalSince1970: 1696187400),
                                      teamID: 117,
                                      logoName: "ti_117",
                                      isHome: false,
                                      opponentName: "Arizona")



struct SimpleEntry: TimelineEntry {
    let date: Date
    let teamID: Int
    let isHome: Bool
    let opponentName: String
    let gameDateTime: Date
}

struct GameEntry: TimelineEntry {
    let date: Date
    let teamID: Int
    let logoName: String
    let isHome: Bool
    let opponentName: String
    
    init(date: Date, teamID: Int, logoName: String, isHome: Bool, opponentName: String) {
        self.date = date
        self.teamID = teamID
        self.logoName = logoName
        self.isHome = isHome
        self.opponentName = opponentName
    }
    
    init(game: Game) {
        self.date = game.date
        self.teamID = 117 // TODO
        self.logoName = "ti_117"
        if game.homeTeam == 117 {
            self.isHome = true
        }
        else {
            self.isHome = false
        }
        self.opponentName = "Anaheim"
    }
}

// for logos

// https://www.mlbstatic.com/team-logos/team-cap-on-dark/117.svg
// https://www.mlbstatic.com/team-logos/team-cap-on-light/117.svg
