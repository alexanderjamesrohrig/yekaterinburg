//
//  MarchUpcomingGameView.swift
//  YekaterinburgTV
//
//  Created by Alexander Rohrig on 3/26/24.
//

import SwiftUI

struct MarchUpcomingGameView: View {
    
    let game: Game
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("NBA")
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .foregroundStyle(.thinMaterial)
                Spacer()
            }
            HStack {
                Text(game.awayTeamName)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .foregroundStyle(.ultraThinMaterial)
                Text(game.date, style: .time)
                    .fontDesign(.rounded)
                    .fontWeight(.heavy)
                Text(game.homeTeamName)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                    .foregroundStyle(.ultraThinMaterial)
            }
            HStack {
                Spacer()
            }
        }
        .padding()
        .background(.regularMaterial)
    }
}

#Preview {
    MarchUpcomingGameView(game: Game.blank)
        .frame(width: 500, height: 100)
}
