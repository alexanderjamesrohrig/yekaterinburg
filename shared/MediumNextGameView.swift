//
//  MediumNextGameView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/16/23.
//

import SwiftUI
import WidgetKit
import UIKit

struct MediumNextGameView: View {
    
    @AppStorage("settingTeamID") private var favoriteTeamID = 117
    var entry: GameEntry
    
    var body: some View {
        HStack() {
            HStack {
                Text(entry.game.awayTeamCode)
                    .fontWeight(.bold)
                    .font(.title)
                    .textCase(.uppercase)
                Divider()
                Text(entry.game.homeTeamCode)
                    .fontWeight(.bold)
                    .font(.title)
                    .textCase(.uppercase)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("Today")
                        .fontWeight(.bold)
                        .font(.caption)
                    Spacer()
                    Text("\(entry.game.date.formatted(date: .omitted, time: .shortened))")
                        .fontWeight(.bold)
                        .font(.caption)
                }
                Divider()
                Text("")
                    .fontWeight(.bold)
                    .font(.caption)
                Text(entry.game.status)
                    .font(.caption)
                Text(entry.game.venue)
                    .font(.caption)
                Text("Updated \(entry.lastUpdate.formatted(date: .omitted, time: .shortened))")
                    .font(.caption)
                Spacer()
                Text(entry.game.televisionOptions)
                    .fontWeight(.bold)
                    .font(.caption)
            }
        }
        .containerBackground(for: .widget) {
            Color(uiColor: UIColor.systemBackground)
        }
    }
}

//#Preview {
//    MediumNextGameView(entry: sampleGameTimelineEntry)
//}
