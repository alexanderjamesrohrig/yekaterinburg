//
//  ContentViewiOS.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI
import OSLog

struct ContentViewiOS: View {
    
    @State private var gamesResponse: [Game] = []
    @State private var season = 2023
    @State private var lastUpdate = Date.distantPast
    @AppStorage("settingTeamID") private var teamID = 117
    @AppStorage("settingTeamCollegeFootballID") private var collegeFootballTeamID = 249
    @AppStorage("settingTeamHockeyID") private var hockeyTeamID = 3
    @ObservedObject var model = ContentModel()
    private let logger = Logger(subsystem: "com.alexanderrohrig.yekaterinburg", category: "ContentViewiOS")
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        List(gamesResponse, id: \.gameID) { game in
            HockeyGameView(homeName: game.homeTeamName, awayName: game.awayTeamName, game: game)
        }
        .toolbar {
            ToolbarButton(action: {
                Task {
                    await gamesResponse = Game.all()
                    lastUpdate = Date.now
                }
            }, title: "Refresh", systemImage: ImageManager.shared.refresh)
            ToolbarButton(action: {
                let url = URL(string: "https://apple.news/myscores")!
                openURL(url)
            }, title: "Open Apple News", systemImage: ImageManager.shared.appleNews)
            ToolbarStatus(text: "Updated \(lastUpdate.formatted(date: .omitted, time: .shortened))")
        }
        .task {
            await gamesResponse = Game.all()
            lastUpdate = Date.now
        }
    }
}

struct ContentViewiOS_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewiOS()
    }
}

