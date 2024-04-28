//
//  SmallGameInProgressView.swift
//  ios-widgetExtension
//
//  Created by Alexander Rohrig on 9/24/23.
//

import SwiftUI

struct SmallGameInProgressView: View {
    
    @AppStorage("settingTeamID") private var favoriteTeamID = 117
    var entry: GameEntry
    
    var body: some View {
        VStack {
            Text("\(entry.game.status)")
            HStack {
                VStack {
                    Text("\(entry.game.awayPoints)")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .fontWidth(.compressed)
                    Text("\(entry.game.awayTeamCode ?? "")")
                        .fontWeight(.heavy)
                        .font(.title)
                        .fontWidth(.compressed)
                        .textCase(.uppercase)
                }
                Divider()
                VStack {
                    Text("\(entry.game.homePoints)")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .fontWidth(.compressed)
                    Text("\(entry.game.homeTeamCode ?? "")")
                        .fontWeight(.heavy)
                        .font(.title)
                        .fontWidth(.compressed)
                        .textCase(.uppercase)
                }
            }
        }
        .containerBackground(for: .widget) {
            Color(uiColor: UIColor.systemBackground)
        }
    }
}

//#Preview {
//    SmallGameInProgressView()
//}
