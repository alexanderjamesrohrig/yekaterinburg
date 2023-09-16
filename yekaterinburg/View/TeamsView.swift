//
//  TeamsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI

struct TeamsView: View {
    
    @State private var teams: [Team] = []
    
    var body: some View {
        ScrollView {
            Grid(alignment: .leading) {
                ForEach(teams, id: \.id) { team in
                    GridRow {
                        Text(team.id, format: .number)
                            .monospaced()
                        Text(team.name)
                        Text(team.parentOrgName)
                    }
                }
            }
            .padding()
            .task {
                print("awaiting all teams...")
                teams = await Team.all
            }
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
