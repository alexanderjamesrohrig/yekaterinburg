//
//  SmallNextGameView.swift
//  ios-widgetExtension
//
//  Created by Alexander Rohrig on 9/17/23.
//

import SwiftUI
import WidgetKit

struct SmallNextGameView: View {
    
    @AppStorage("settingTeamID") private var favoriteTeamID = 117
    var entry: GameEntry
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    if entry.date < Date.now {
                        Text(entry.game.status)
                    }
                    else {
                        Text("Next")
                            .font(.caption)
                    }
                    Spacer()
                    if entry.game.awayTeam == favoriteTeamID {
                        Image(systemName: "airplane.departure")
                    }
                }
                HStack {
                    if entry.game.awayTeam == favoriteTeamID {
                        Text(entry.game.homeTeamName)
                    }
                    else {
                        Text(entry.game.awayTeamName)
                    }
                }.font(.headline)
                Spacer()
                if entry.date < Date.now {
                    Text(entry.date, style: .time).font(.caption)
                }
                else {
                    Text(entry.date, style: .relative).font(.caption)
                }
            }
        }.containerBackground(for: .widget) {
            Color(uiColor: UIColor.systemBackground)
        }
    }
}
