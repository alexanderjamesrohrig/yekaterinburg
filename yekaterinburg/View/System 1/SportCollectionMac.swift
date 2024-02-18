//
//  SportCollectionMac.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/14/23.
//

import SwiftUI

struct SportCollectionMac: View {
    
    #if os(macOS)
    @Environment(\.openWindow) private var openWindow
    #endif
    @State private var hockeyGames: [HockeyResponse.NHLDate.NHLGame] = []
    @State private var games: [Game] = []
    @State private var showAddScheduledGameSheet = false
    private let apiSources: Set<YeType> = [.game(.basketball)]
    private let viewModel = System1ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button("Open Basketball Standings") {}
            }
            List(games) { game in
                HStack {
                    Text("\(game.awayTeamName) at \(game.homeTeamName)")
                    Spacer()
                    Text(game.status)
                }
            }
            .padding(.top)
        }
        .padding(.top)
        .task {
            games = await viewModel.getGamesFrom(sources: apiSources)
        }
        .toolbar {
            ToolbarStatus(text: "Updated \(Date.now.formatted(date: .abbreviated, time: .shortened))")
            ToolbarButton(action: {
//                openWindow(id: WindowManager.shared.teams)
            }, title: "View Teams", systemImage: ImageManager.shared.teams)
            ToolbarButton(action: {
//                openWindow(id: WindowManager.shared.schedule)
            }, title: "View Schedule", systemImage: ImageManager.shared.schedule)
            ToolbarButton(action: {
//                games = await viewModel.getGamesFrom(sources: apiSources)
            }, title: "Refresh", systemImage: ImageManager.shared.refresh)
            ToolbarButton(action: {
                showAddScheduledGameSheet = true
            }, title: "Add Scheduled Game", systemImage: ImageManager.shared.add)
        }
        .sheet(isPresented: $showAddScheduledGameSheet, content: {
            AddScheduledGameView()
        })
    }
}

#Preview {
    SportCollectionMac()
}
