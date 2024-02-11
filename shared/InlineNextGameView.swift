//
//  InlineNextGameView.swift
//  ios-widgetExtension
//
//  Created by Alexander Rohrig on 9/17/23.
//

import SwiftUI

struct InlineNextGameView: View {
    
    @AppStorage("settingTeamID") private var favoriteTeamID = 117
    
    var entry: GameEntry
    
    var body: some View {
        if entry.game.homeTeam == favoriteTeamID {
            HStack {
                Text("\(entry.game.date.formatted(date: .omitted, time: .shortened)): \(entry.game.awayTeamName)")
            }
        }
        else {
            HStack {
                Text("\(entry.game.date.formatted(date: .omitted, time: .shortened)) at \(entry.game.homeTeamName)")
            }
        }
    }
}

//struct InlineNextGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        InlineNextGameView(entry: sampleGameTimelineEntry)
//    }
//}
