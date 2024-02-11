//
//  HockeyGameView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/13/23.
//

import SwiftUI

struct InProgressGameView: View {
    
    let homeName: String
    let awayName: String
//    let status: String
//    let date: Date
//    let broadcast: String
//    let awayScore: Int
//    let homeScore: Int
    let game: Game
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text("\(game.status) - \(game.date.formatted(date: .omitted, time: .shortened))")
                .fontWeight(.bold)
            HStack {
                Text(awayName)
                Spacer()
                Text("\(game.awayPoints)")
            }
            HStack {
                Text(homeName)
                Spacer()
                Text("\(game.homePoints)")
            }
            HStack {
                Spacer()
                Text("Radio: <RADI>")
                Text("TV: <TV>")
            }
            .font(.caption2)
            .fontWidth(.compressed)
        }
    }
}

#Preview {
    InProgressGameView(homeName: "Home", awayName: "Away", game: Game.blank)
}
