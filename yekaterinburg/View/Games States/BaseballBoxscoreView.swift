//
//  BoxscoreView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/7/23.
//

import SwiftUI

struct BaseballBoxscoreView: View {
    
    let game: ResponseDateGame
    
    var body: some View {
        Grid {
            GridRow {
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                ForEach(1 ..< 10) { i in
                    Text(i, format: .number)
                }
                Text("R")
                Text("H")
                Text("E")
            }
            GridRow {
                Text(game.teams.away.team.teamCode)
                    .monospaced()
                    .textCase(.uppercase)
            }
            GridRow {
                Text(game.teams.home.team.teamCode)
                    .monospaced()
                    .textCase(.uppercase)
            }
            GridRow {
                Text("\(game.status.detailedState), \(DateAdapter.timeFrom(gameDate: game.gameDate, withDate: false))")
                    .gridCellColumns(13)
            }
        }
    }
}
