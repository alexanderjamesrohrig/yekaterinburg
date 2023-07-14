//
//  TeamsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 6/30/23.
//

import SwiftUI

struct TeamsView: View {
    
    @ObservedObject var model = ContentModel()
    @State private var response: TeamResponse?
    
    var body: some View {
        Grid {
            if let r = response {
                ForEach(r.teams, id: \.id) { team in
                    GridRow {
                        Text("\(team.id)")
                        Text(team.clubName)
                        Text(team.parentOrgName)
                    }
                }
            }
        }
        .padding()
        .task {
            do {
                try response = await model.getIDForTeams()
            }
            catch {
                print("TEAM RESPONSE ERROR")
            }
        }
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
    }
}
