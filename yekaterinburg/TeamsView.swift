//
//  TeamsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI
import OSLog

struct TeamsView: View {
    
    private let logger = Logger(subsystem: GeneralSecretary.shared.subsystem, category: "TeamsView")
    @StateObject private var viewModel = TeamsViewModel()
    
    var body: some View {
        Table(viewModel.teams, sortOrder: $viewModel.sortOrder) {
            TableColumn(SM.shared.favoriteColumnName) { team in
                Toggle("", isOn: $viewModel.teams[viewModel.firstIndex(team)].favorite)
            }
            TableColumn(SM.shared.idColumnName, value: \.sportSpecificID) { team in
                Text(verbatim: "\(team.sportSpecificID)")
                    .monospaced()
            }
            TableColumn(SM.shared.nameColumnName, value: \.name)
            TableColumn(SM.shared.parentOrgColumnName, value: \.parentOrgName)
            TableColumn(SM.shared.sportColumnName) { teamRow in
                displayName(for: teamRow.sport)
            }
        }
        .onChange(of: viewModel.sortOrder) { _, newSort in
            viewModel.teams.sort(using: newSort)
        }
        .task {
            viewModel.teams = await Team.all
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
