//
//  TeamsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI

struct TeamsView: View {
    
    @State private var teams: [Team] = []
    @State private var sortOrder = [KeyPathComparator(\Team.id)]
    
    var body: some View {
        Table(teams, sortOrder: $sortOrder) {
            TableColumn("Id") { team in
                Text(verbatim: "\(team.id)")
                    .monospaced()
            }
            TableColumn("Name", value: \.name)
            TableColumn("Parent organization", value: \.parentOrgName)
            TableColumn("Sport") { teamRow in
                displayName(for: teamRow.sport)
            }
        }
        .onChange(of: sortOrder) { _, newSort in
            teams.sort(using: newSort)
        }
        .task {
            teams = await Team.all
        }
    }
    
    private func displayName(for sport: YeType) -> some View {
        switch sport {
        case .event:
            Text("Event")
        case .game(.baseball):
            Text("Baseball")
        case .game(.basketball):
            Text("Basketball")
        case .game(.calcio):
            Text("Soccer")
        case .game(.hockey):
            Text("Hockey")
        default:
            Text("Unknown sport")
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
