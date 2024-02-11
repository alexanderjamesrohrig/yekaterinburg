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
    @State private var showScheduleSheet = false
    @State private var showSettingsSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Yekaterinburg")
                .font(.title)
                .bold()
            Text("Upcoming Games")
                .font(.headline)
            ScrollView(.horizontal) {
                LazyHGrid(rows: upcomingGamesRows, spacing: 50) {
                    ForEach(1...7, id: \.self) { game in
                        // TODO: GameStatusView for games not yet started, today to +7 days
                        // TODO: InProgressGameView for games in progress, today
                        GameStatusView(game: Game.blank)
                    }
                }
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
    }
}

#Preview {
    ContentViewForTV()
}
