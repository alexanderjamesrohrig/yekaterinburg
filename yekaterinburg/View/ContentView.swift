//
//  ContentView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var response: Response?
    @State private var hockeyRes: [HockeyResponse.NHLDate.NHLGame]?
    @AppStorage("settingTeamID") private var teamID = 117
    @AppStorage("settingTeamCollegeFootballID") private var collegeFootballTeamID = 249
    @AppStorage("settingTeamHockeyID") private var hockeyTeamID = 3
    @State private var season = 2023
    @ObservedObject var model = ContentModel()
//    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        Form {
            Section("Today") {
                Grid {
                    /// Baseball
                    if let r = response {
                        ForEach(r.dates, id: \.self) { date in
                            ForEach(date.games, id: \.self) { game in
                                GridRow {
                                    Text(model.getStringFrom(date: game.gameDate))
                                    Text(game.teams.away.team.franchiseName)
                                        .fontWeight(.bold)
                                    Text("at")
                                    Text(game.teams.home.team.franchiseName)
                                        .fontWeight(.bold)
                                    Text(game.status.detailedState)
                                    Link("MLB.com", destination: URL(string: "https://www.mlb.com/gameday/\(game.gamePk)")!)
                                    // Text("as of \(Date())") // TODO shorten to time only
                                }
                            }
                        }
                    } else {
                        Label("No Response", systemImage: ImageManager.shared.baseball)
                    }
                    Divider()
                    /// College Football
                    Label("No Response", systemImage: ImageManager.shared.football)
                    Divider()
                    /// Hockey
                    GridRow {
//                        Text(DateAdapter.YeFormatString(from: Date.now))
                        Text("\(Date.now.formatted(date: .omitted, time: .shortened))")
                        Text("<A>")
                            .monospaced()
                            .fontWeight(.bold)
                        Text("at")
                        Text("<H>")
                            .monospaced()
                            .fontWeight(.bold)
                        Text("<Status>")
                        Text("<Radio/TV>")
                    }
                }
            }
        }
        .padding()
        .task {
            do {
                let todayDate = model.getTodayInAPIFormat()
                try response = await model.getGamesFor(date: todayDate, team: teamID)
                hockeyRes = Game.gamesToday(for: .game(.hockey), date: "2024-02-05", team: 3)
            }
            catch {
                print("RESPONSE ERROR")
            }
        }
        .toolbar {
//            ToolbarItem(placement: .status) {
//                Text("Updated \(Date.now.formatted(date: .abbreviated, time: .shortened))")
//            }
            ToolbarItem(placement: .automatic) {
                Button {
//                    openWindow(id: "teams")
                } label: {
                    Label("View Teams", systemImage: ImageManager.shared.teams)
                }
            }
            ToolbarItem(placement: .automatic) {
                Button {
//                    openWindow(id: "sched")
                } label: {
                    Label("View Schedule", systemImage: ImageManager.shared.schedule)
                }
            }
            ToolbarItem(placement: .automatic) {
                Button {
                    print("Refresh")
                } label: {
                    Label("Refresh", systemImage: ImageManager.shared.refresh)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
