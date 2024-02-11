//
//  SportCollectionMac.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/14/23.
//

import SwiftUI

struct SportCollectionMac: View {
    
    @Environment(\.openWindow) private var openWindow
    @State private var baseballGames: [ResponseDateGame] = []
    @State private var hockeyGames: [HockeyResponse.NHLDate.NHLGame] = []
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 20)], content: {
            Text("Coming soon...")
//            ForEach(Game.sample, id: \.gameID) { game in
//                HockeyGameView(homeName: game.homeTeamName, awayName: game.awayTeamName, status: game.status, date: game.date, broadcast: "ESPN")
//            }
//            ForEach(baseballGames, id: \.gamePk) { game in
//                HockeyGameView(homeName: game.teams.home.team.teamCode, awayName: game.teams.away.team.teamCode, status: game.status.detailedState, date: Date.now, broadcast: "")
//            }
//            ForEach(hockeyGames, id: \.gamePk) { game in
//                HockeyGameView(homeName: Game.name(game.teams.home.team), awayName: Game.name(game.teams.away.team), status: game.status.detailedState, date: Date.now, broadcast: "")
//            }
        })
        .padding()
        .task {
            do {
                baseballGames = Game.baseballGames(for: Date.now, team: 117)
                hockeyGames = Game.gamesToday(for: .game(.hockey), date: "2023-10-12")
            } catch {
                print(error)
            }
        }
        .toolbar {
            ToolbarStatus(text: "Updated \(Date.now.formatted(date: .abbreviated, time: .shortened))")
            ToolbarButton(action: {
                openWindow(id: WindowManager.shared.teams)
            }, title: "View Teams", systemImage: ImageManager.shared.teams)
            ToolbarButton(action: {
                openWindow(id: WindowManager.shared.schedule)
            }, title: "View Schedule", systemImage: ImageManager.shared.schedule)
            ToolbarButton(action: {
                // TODO: - refresh
            }, title: "Refresh", systemImage: ImageManager.shared.refresh)
        }
    }
}

#Preview {
    SportCollectionMac()
}
