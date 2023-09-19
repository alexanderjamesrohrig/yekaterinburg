//
//  CircularNextGameView.swift
//  ios-widgetExtension
//
//  Created by Alexander Rohrig on 9/17/23.
//

import SwiftUI

struct CircularNextGameView: View {
    
    @AppStorage("settingTeamID") private var favoriteTeamID = 117
    
    var entry: GameEntry
    
    var body: some View {
        if entry.game.homeTeam == favoriteTeamID {
            VStack {
                Text(entry.game.date, style: .time)
                Text(entry.game.awayTeamCode)
                    .textCase(.uppercase)
                    .monospaced()
            }
        }
        else {
            VStack {
                Text(entry.game.date, style: .time)
                Text(entry.game.homeTeamCode)
                    .textCase(.uppercase)
                    .monospaced()
            }
        }
    }
}

struct CircularNextGameView_Previews: PreviewProvider {
    static var previews: some View {
        CircularNextGameView(entry: sampleGameTimelineEntry)
    }
}
