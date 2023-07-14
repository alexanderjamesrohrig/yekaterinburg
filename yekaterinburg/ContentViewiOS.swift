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
            Section("TODAY'S GAME") {
                if let r = response {
                    ForEach(r.dates, id: \.self) { date in
                        ForEach(date.games, id: \.self) { game in
                            HStack {
                                VStack {
                                    Text("\(game.teams.away.team.locationName) at \(game.teams.home.team.locationName)").font(.headline)
                                    Text("\(game.status.detailedState) - \(model.getStringFrom(date: game.gameDate))").font(.subheadline)
                                }
                            }
                        }
                    }
                    Text("\(r.copyright)").font(.caption)
                }
            }
            Section("CODENAME YEKATERINBURG") {
                Stepper("TEAM \(teamID)", value: $teamID)
                Link("VIEW TEAM NUMBERS", destination: URL(string: "https://github.com/alexanderjamesrohrig/yekaterinburg/wiki/TEAM-NUMBERS")!)
                Text("COPYRIGHT ⅯⅯⅩⅩⅢ")
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

