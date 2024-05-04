//
//  GameListView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/18/24.
//

import SwiftUI
import OSLog

struct tvView: View {
    
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "GameListView")
    private let apiSources: Set<YeType> = [.game(.basketball),
                                           .game(.calcio),
                                           .game(.baseball)]
    private let viewModel = System1ViewModel()
    @State private var games: [Game] = []
    @State private var lastUpdate = Date.distantPast
#if DEBUG
    @State private var useMockData: Bool = true
#else
    @State private var useMockData: Bool = false
#endif
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 0) {
#if DEBUG
//                DebugView(useMockData: $useMockData)
#endif
                List(games) { game in
                    HStack {
                        HStack {
                            Text("\(game.awayTeamName) at \(game.homeTeamName)")
                        }
                        Spacer()
                        HStack {
                            if game.televisionOptions.isEmpty {
                                Label("No TV options", systemImage: ImageManager.shared.noTV)
                                    .labelStyle(.iconOnly)
                                    .foregroundStyle(.thickMaterial)
                            } else {
                                Label(game.televisionOptions, systemImage: ImageManager.shared.tv)
                                    .foregroundStyle(.thickMaterial)
                            }
                            if !game.radioOptions.isEmpty {
                                Label(game.radioOptions, systemImage: ImageManager.shared.radio)
                                    .foregroundStyle(.thickMaterial)
                            }
                            Text(game.date, formatter: DateAdapter.mediumDateShortTime)
                                .foregroundStyle(.ultraThickMaterial)
                                .monospacedDigit()
                        }
                    }
                }
                .background(.ultraThinMaterial)
            }
        }
        .task {
            games = await viewModel.getGamesFrom(sources: apiSources, useMockData: useMockData)
            lastUpdate = Date.now
        }
    }
}

#Preview {
    tvView()
}
