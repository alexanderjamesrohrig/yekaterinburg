//
//  ContentViewiOS.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI
import OSLog

struct ContentViewiOS: View {
    
//    @State private var gamesResponse: [Game] = []
//    @State private var season = 2023
    @State private var lastUpdate = Date.distantPast
//    @AppStorage("settingTeamID") private var teamID = 117
//    @AppStorage("settingTeamCollegeFootballID") private var collegeFootballTeamID = 249
//    @AppStorage("settingTeamHockeyID") private var hockeyTeamID = 3
//    @ObservedObject var model = ContentModel()
    @Environment(\.openURL) private var openURL
    @State private var games: [Game] = []
    @State private var showAddScheduledGameSheet = false
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "ContentViewiOS")
    private let apiSources: Set<YeType> = [.game(.basketball)]
    let viewModel = System1ViewModel()
    
    var body: some View {
        List(games) { game in
            InProgressGameView(homeName: game.homeTeamName, awayName: game.awayTeamName, game: game)
        }
        .toolbar {
            ToolbarButton(action: {
                Task {
                    games = await viewModel.getGamesFrom(sources: apiSources)
                    lastUpdate = Date.now
                }
            }, title: "Refresh", systemImage: ImageManager.shared.refresh)
            ToolbarButton(action: {
                let url = URL(string: "https://apple.news/myscores")!
                openURL(url)
            }, title: "Open Apple News", systemImage: ImageManager.shared.appleNews)
            ToolbarButton(action: {
                showAddScheduledGameSheet = true
            }, title: "Add Game", systemImage: ImageManager.shared.add)
            ToolbarStatus(text: "Updated \(lastUpdate.formatted(date: .omitted, time: .shortened))")
        }
        .task {
//            await gamesResponse = Game.all()
//            guard let nbaGame = NBAAPI.games()?.data.first else {
//                logger.error("Unable to get game from NBA API")
//                return
//            }
//            gamesResponse.append(GameAdapter.getGameFrom(nbaGame))
//            games = viewModel.getGamesFrom(sources: apiSources)
//            lastUpdate = Date.now
        }
        .sheet(isPresented: $showAddScheduledGameSheet, content: {
            AddScheduledGameView()
        })
    }
}

struct ContentViewiOS_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewiOS()
    }
}

