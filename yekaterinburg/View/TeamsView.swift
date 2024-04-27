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
        // TODO: Right click to set as favorite
        Table(teams, sortOrder: $sortOrder) {
            TableColumn(SM.shared.idColumnName, value: \.id) { team in
                Text(verbatim: "\(team.id)")
                    .monospaced()
            }
            TableColumn(SM.shared.nameColumnName, value: \.name)
            TableColumn(SM.shared.parentOrgColumnName, value: \.parentOrgName)
            TableColumn(SM.shared.sportColumnName) { teamRow in
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
            Text(SM.shared.eventLabel)
        case .game(.baseball):
            Text(SM.shared.baseballLabel)
        case .game(.basketball):
            Text(SM.shared.basketballLabel)
        case .game(.calcio):
            Text(SM.shared.soccerLabel)
        case .game(.hockey):
            Text(SM.shared.hockeyLabel)
        default:
            Text(SM.shared.unknownLabel)
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
