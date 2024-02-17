//
//  ContentView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI
import OSLog

struct ContentView: View {
    
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "ContentView")
    private let apiSources: Set<YeType> = [.game(.basketball),
                                           .game(.calcio),
                                           .game(.baseball)]
    private let viewModel = System1ViewModel()
    @State private var games: [Game] = []
    @State private var useMockData: Bool = true
    @State private var lastUpdate = Date.distantPast
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        #if DEBUG
        VStack {
            Text("DEBUG_INFORMATION")
            Text(GeneralSecretary.shared.appVersion)
            Toggle("USE_MOCK_DATA", isOn: $useMockData)
        }
        #endif
        List(games) { game in
            HStack {
                Text("\(game.awayTeamName) at \(game.homeTeamName)")
                Spacer()
                Text(DateAdapter.yeFormatWithTime(from: game.date))
                    .foregroundStyle(.gray)
            }
        }
        .toolbar {
            ToolbarButton(action: {
                Task {
                    games = await viewModel.getGamesFrom(sources: apiSources, useMockData: useMockData)
                    lastUpdate = Date.now
                }
            }, title: "Refresh", systemImage: ImageManager.shared.refresh)
            ToolbarButton(action: {
                let url = URL(string: "https://apple.news/myscores")!
                openURL(url)
            }, title: "Open Apple News", systemImage: ImageManager.shared.appleNews)
            ToolbarButton(action: {
                openURL(URL(string: "https://plaintextsports.com/nfl/2023/schedule")!)
            }, title: "NFL", systemImage: ImageManager.shared.football)
            ToolbarButton(action: {
                openURL(URL(string: "https://plaintextsports.com/nhl/2023-2024/schedule")!)
            }, title: "NHL", systemImage: ImageManager.shared.hockey)
            ToolbarStatus(text: "Updated \(lastUpdate.formatted(date: .omitted, time: .shortened))")
        }
        .task {
            games = await viewModel.getGamesFrom(sources: apiSources, useMockData: useMockData)
            lastUpdate = Date.now
        }
        .onChange(of: scenePhase) { _, phase in
            switch scenePhase {
            case .inactive:
                logger.info("Switched to inactive scene state")
                // TODO: save only created games
            default:
                logger.info("Switched to other scene state")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
