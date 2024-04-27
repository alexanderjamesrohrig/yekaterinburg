//
//  macView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI
import OSLog

struct macView: View {
    
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "ContentView")
    private let apiSources: Set<YeType> = [.game(.basketball),
                                           .game(.calcio),
                                           .game(.baseball),
                                           .game(.hockey)]
    @AppStorage(StringManager.shared.storageFFMockData) private var useMockData: Bool = true
    @State private var games: [Game] = []
    @State private var lastUpdate = Date.distantPast
    @State private var showSettingsSheet = false
    @State private var showDebugSheet = false
    @StateObject private var viewModel = System1ViewModel()
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack {
            BackgroundView()
            if viewModel.state == .success {
                gamesListView()
            } else if viewModel.state == .loading {
                ProgressView()
            } else if viewModel.state == .noGames {
                Text(SM.shared.noGamesText)
                    .foregroundStyle(.regularMaterial)
            }
        }
        .sheet(isPresented: $showDebugSheet) {
            DebugView(useMockData: $useMockData)
        }
        .sheet(isPresented: $showSettingsSheet) {
            SettingsView()
                .presentationDetents([.medium, .large])
        }
        .toolbarBackground(.regularMaterial)
        .toolbar {
            #if DEBUG
            ToolbarButton(action: {
                showDebugSheet = true
            }, title: "DEBUG", systemImage: ImageManager.shared.ff)
            #endif
            ToolbarButton(action: {
                Task {
                    games = await viewModel.getGamesFrom(sources: apiSources, useMockData: useMockData)
                    lastUpdate = Date.now
                }
            }, title: SM.shared.refreshButtonTitle, systemImage: ImageManager.shared.refresh)
            ToolbarButton(action: {
                let url = URL(string: "https://apple.news/myscores")!
                openURL(url)
            },
                          title: SM.shared.openAppleNewsButtonTitle,
                          systemImage: ImageManager.shared.appleNews)
            ToolbarButton(action: {
                showSettingsSheet = true
            }, title: SM.shared.settingsButtonTitle, systemImage: ImageManager.shared.settings, isSettings: true)
            ToolbarStatus(text: "\(SM.shared.updated) \(lastUpdate.formatted(date: .omitted, time: .shortened))")
        }
        .task {
            viewModel.state = .loading
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
    
    @ViewBuilder private func gamesListView() -> some View {
        VStack(spacing: 0) {
            List(games) { game in
                HStack {
                    HStack {
                        if game.type != .event {
                            Text("\(game.awayTeamName)\(SM.shared.at)\(game.homeTeamName)")
                                .fontDesign(.rounded)
                                .font(.headline)
                        } else {
                            Text(game.homeTeamName)
                                .fontDesign(.rounded)
                                .font(.headline)
                        }
                    }
                    Spacer()
                    Text(game.televisionOptions)
                        .foregroundStyle(.regularMaterial)
                        .fontDesign(.rounded)
                    Text(DateAdapter.yeFormatWithTime(from: game.date))
                        .monospacedDigit()
                        .fontDesign(.rounded)
                }
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        macView()
    }
}