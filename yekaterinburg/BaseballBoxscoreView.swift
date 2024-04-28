//
//  BoxscoreView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/7/23.
//

import SwiftUI

struct BaseballBoxscoreView: View {
    
    let game: Game
    
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
                Text(game.awayTeamCode)
                    .monospaced()
                    .textCase(.uppercase)
            }
            GridRow {
                Text(game.homeTeamCode)
                    .monospaced()
                    .textCase(.uppercase)
            }
            GridRow {
                HStack {
                    Text("\(game.status), ")
                    Text(game.date, style: .time)
                }
                .gridCellColumns(13)
            }
        }
    }
}
