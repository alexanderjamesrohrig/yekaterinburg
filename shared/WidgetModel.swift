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
let sampleGame = Game(gameID: 111111, homeTeam: 117, homeTeamName: "Houston", homeTeamCode: "HOU", awayTeam: 118, awayTeamName: "New York Yankees", awayTeamCode: "NYY", date: Date(timeIntervalSince1970: 1694905800), status: "Scheduled")
let sampleGameTimelineEntry: GameEntry = GameEntry(game: sampleGame)



struct SimpleEntry: TimelineEntry {
    let date: Date
    let teamID: Int
    let isHome: Bool
    let opponentName: String
    let gameDateTime: Date
}

struct GameEntry: TimelineEntry {
    var date: Date
    let game: Game
    
    init(game: Game) {
        self.game = game
        self.date = game.date
    }
}

// for logos

// https://www.mlbstatic.com/team-logos/team-cap-on-dark/117.svg
// https://www.mlbstatic.com/team-logos/team-cap-on-light/117.svg
