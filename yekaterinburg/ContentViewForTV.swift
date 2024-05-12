//
//  ContentViewForTV.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/10/24.
//

import SwiftUI

struct ContentViewForTV: View {
    
    private let upcomingGamesRows = [GridItem(.fixed(100))]
    private let standingsRows = [GridItem(.fixed(100))]
    private let apiSources: Set<YeType> = [.game(.basketball)]
    @State private var showScheduleSheet = false
    @State private var showSettingsSheet = false
    @State var games: [Game] = []
    @StateObject private var viewModel = System1ViewModel()
    
    var body: some View {
        Text(GeneralSecretary.shared.appName)
            .font(.largeTitle)
            .task {
                games = await viewModel.getGamesFrom(sources: apiSources)
            }
        HStack {
            VStack {
                Text("Upcoming Games")
                    .font(.headline)
                List(games) { game in
                    HStack {
                        Text("\(game.awayTeamName) at \(game.homeTeamName)")
                        Spacer()
                        Text(DateAdapter.yeFormatString(from: game.date))
                            .foregroundStyle(.gray)
                    }
                }
            }
            VStack {
                Text("Standings")
                    .font(.headline)
                Spacer()
                List(1..<4) { standing in
                    HStack {
                        Text("Team \(standing)")
                        Spacer()
                        Text("<>th in <>")
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
            }
        }
        /*VStack(alignment: .leading) {
            Text("Yekaterinburg")
                .font(.title)
                .bold()
            Text("Upcoming Games")
                .font(.headline)
            ScrollView(.horizontal) {
                LazyHGrid(rows: upcomingGamesRows, spacing: 50) {
                    ForEach(games, id: \.gameID) { game in
                        // TODO: GameStatusView for games not yet started, today to +7 days
                        // TODO: InProgressGameView for games in progress, today
//                        GameStatusView(game: game)
                    }
                }
            }
            .task {
                games = viewModel.getGamesFrom(sources: apiSources)
            }
            Text("Standings")
                .font(.headline)
            ScrollView(.horizontal) {
                LazyHGrid(rows: standingsRows) {
                    ForEach(Game.supportedLeagues, id: \.self) { league in
                        Text(league)
                    }
                }
            }
            Spacer()
            HStack {
                Button("Schedule") {
                    showScheduleSheet = true
                }
                .sheet(isPresented: $showScheduleSheet) {
                    ScheduleView()
                }
                Button("Settings") {
                    showSettingsSheet = true
                }
                .sheet(isPresented: $showSettingsSheet) {
                    RohrigView()
                }
            }
        }
         */
    }
}

#Preview {
    ContentViewForTV(games: [Game.blank])
}
