//
//  SmallNextGameView.swift
//  ios-widgetExtension
//
//  Created by Alexander Rohrig on 9/17/23.
//

import SwiftUI

struct SmallNextGameView: View {
    
    @AppStorage("settingTeamID") private var favoriteTeamID = 117
    
    var entry: GameEntry
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    if entry.date < Date() {
                        Text(entry.game.status)
                    }
                    else {
                        Text("Next")
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
                if entry.date < Date() {
                    Text(entry.date, style: .time)
                }
                else {
                    Text(entry.date, style: .relative)
                }
            }.padding()
        }.containerBackground(for: .widget) {
            if entry.game.homeTeam == favoriteTeamID {
                Color.white
            }
            else {
                Color.gray
            }
        }
    }
}

struct SmallNextGameView_Previews: PreviewProvider {
    static var previews: some View {
        SmallNextGameView(entry: sampleGameTimelineEntry)
    }
}
