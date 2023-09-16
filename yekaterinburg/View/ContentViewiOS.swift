//
//  ContentViewiOS.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI

struct ContentViewiOS: View {
    
    @State private var response: Response?
    @AppStorage("settingTeamID") private var teamID = 117
    @State private var season = 2023
    @ObservedObject var model = ContentModel()
    
    var body: some View {
        Form {
            Section("Today") {
                if let r = response {
                    ForEach(r.dates, id: \.self) { date in
                        ForEach(date.games, id: \.self) { game in
                            Grid {
                                GridRow {
                                    Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                                    ForEach(1 ..< 10) { i in
                                        Text(i, format: .number)
                                    }
                                    Text("R")
                                    Text("H")
                                    Text("E")
                                }
                                GridRow {
                                    Text(game.teams.away.team.teamCode)
                                        .monospaced()
                                        .textCase(.uppercase)
                                }
                                GridRow {
                                    Text(game.teams.home.team.teamCode)
                                        .monospaced()
                                        .textCase(.uppercase)
                                }
                                GridRow {
                                    Text("\(game.status.detailedState), \(DateAdapter.timeFrom(gameDate: game.gameDate, withDate: false))")
                                        .gridCellColumns(13)
                                }
                            }
                        }
                    }
                }
            }
            Section("Options") {
                Stepper("Team \(teamID)", value: $teamID)
                RohrigView()
            }
        }
        .task {
            do {
                let dateToday = model.getTodayInAPIFormat()
                try response = await model.getGamesFor(date: dateToday, team: teamID)
            }
            catch {
                print("RESPONSE ERROR")
            }
        }
    }
}

struct ContentViewiOS_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewiOS()
    }
}

