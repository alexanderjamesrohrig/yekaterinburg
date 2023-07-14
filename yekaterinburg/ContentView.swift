//
//  ContentView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var response: Response?
    @AppStorage("settingTeamID") private var teamID = 117
    @State private var season = 2023
    @ObservedObject var model = ContentModel()
    
    var body: some View {
        Form {
            Section("TODAY'S GAME") {
                if let r = response {
                    Grid {
                        ForEach(r.dates, id: \.self) { date in
                            ForEach(date.games, id: \.self) { game in
                                GridRow {
                                    Text(model.getStringFrom(date: game.gameDate))
                                    Text(game.teams.away.team.locationName)
                                    Text("at")
                                    Text(game.teams.home.team.locationName)
                                    Text(game.status.detailedState)
                                    Link("MLB.com", destination: URL(string: "https://www.mlb.com/gameday/\(game.gamePk)")!)
                                }
                            }
                        }
                        Divider()
                        Text("\(r.copyright)")
                            .textSelection(.enabled)
                    }
                }
            }
            Divider()
            Section("CODENAME YEKATERINBURG") {
                Stepper("TEAM \(teamID)", value: $teamID)
                Link("VIEW TEAM NUMBERS", destination: URL(string: "https://github.com/alexanderjamesrohrig/yekaterinburg/wiki/TEAM-NUMBERS")!)
                Text("COPYRIGHT ⅯⅯⅩⅩⅢ")
            }
        }
        .padding()
        .task {
            do {
                let todayDate = model.getTodayInAPIFormat()
                try response = await model.getGamesFor(date: todayDate, team: teamID)
            }
            catch {
                print("RESPONSE ERROR")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
