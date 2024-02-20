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
            TableColumn("id") { team in
                Text(verbatim: "\(team.id)")
                    .monospaced()
            }
            TableColumn("name", value: \.name)
            TableColumn("parent organization", value: \.parentOrgName)
            TableColumn("sport") { team in
                Text("Baseball")
            }
        }
        .onChange(of: sortOrder) { _, newSort in
            teams.sort(using: newSort)
        }
        .task {
            teams = await Team.all
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
