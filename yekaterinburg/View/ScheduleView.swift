//
//  ScheduleView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 8/16/23.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject var model = ContentModel()
    @State private var schedResponse: Response?
    @State private var games: [ResponseDateGame] = []
    @AppStorage("settingTeamID") private var teamID = 117
    
    var body: some View {
        VStack {
            if let s = schedResponse {
                List(s.dates, id: \.date) { date in
                    if date.games.count == 1 {
                        HStack {
                            Text(date.games.first?.officialDate ?? "YYYY-MM-DD")
                            if let x = date.games.first {
                                if x.teams.away.team.id == teamID {
                                    Text("\(x.teams.home.team.franchiseName)")
                                    Image(systemName: "airplane.departure")
                                }
                                else {
                                    Text("\(x.teams.away.team.franchiseName)")
                                }
                            }
                        }
                    }
                    else {
                        Text("Double Header. Support coming soon.")
                    }
                }
            }
            Divider().task {
                // MVC:
                // games = await Games.all
                
                do {
                    print("loading schedule...")
                    try schedResponse = await model.getSeasonScheduleFor(season: "2023", team: teamID)
                }
                catch {
                    print("RESPONSE ERROR")
                }
            }
            // 1871 - 2023
            Text("The One Hundred and Fifty Second Year of Professional Baseball.")
        }.padding()
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
