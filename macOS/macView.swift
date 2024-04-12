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
                                           .game(.baseball)]
    private let viewModel = System1ViewModel()
    @State private var games: [Game] = []
    @AppStorage(StringManager.shared.storageFFMockData) private var useMockData: Bool = true
    @State private var lastUpdate = Date.distantPast
    @State private var showSettingsSheet = false
    @State private var showDebugSheet = false
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 0) {
                List(games) { game in
                    HStack {
                        HStack {
                            if game.type != .event {
                                Text("\(game.awayTeamName) at \(game.homeTeamName)")
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
            }, title: "Refresh", systemImage: ImageManager.shared.refresh)
            ToolbarButton(action: {
                let url = URL(string: "https://apple.news/myscores")!
                openURL(url)
            }, title: "Open Apple News", systemImage: ImageManager.shared.appleNews)
            ToolbarButton(action: {
                showSettingsSheet = true
            }, title: "Settings", systemImage: ImageManager.shared.settings, isSettings: true)
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
        macView()
    }
}
