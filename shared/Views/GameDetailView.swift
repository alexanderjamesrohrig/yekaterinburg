//
//  GameDetailView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/17/24.
//

import SwiftUI

struct GameDetailView: View {
    
    let game: Game
    
    var body: some View {
        ZStack {
            Color.lightestGray
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("\(game.awayTeamName) at")
                        .font(.headline)
                    Spacer()
                }
                Text("\(game.awayPoints) - \(game.homePoints)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .fontWidth(.expanded)
                HStack {
                    Spacer()
                    Text("\(game.homeTeamName)")
                        .font(.headline)
                }
                Divider()
                Form {
                    Text(game.status)
                    Text(game.date, style: .date)
                    Text(game.venue)
                    Text(game.televisionOptions)
                    Text(game.radioOptions)
                }
            }
            .padding()
        }
    }
}

#Preview {
    GameDetailView(game: Game.blank)
}
