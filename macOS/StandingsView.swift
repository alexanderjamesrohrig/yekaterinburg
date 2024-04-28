//
//  StandingsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/25/24.
//

import SwiftUI

struct StandingsView: View {
    
    @State private var standings: WorldFootballStandingsResponse?
    
    var body: some View {
        Grid {
            if let table = standings?.standings?.first?.table {
                GridRow {
                    Text("Club")
                    Text("Pts")
                }
                ForEach(0..<18, id: \.self) { row in
                    GridRow {
                        Text("\(table[row].team.name ?? "")")
                        Text("##")
                    }
                }
            } else {
                
            }
        }
        .task {
            standings = await WorldFootballAPI.standings(for: "BL1")
        }
    }
}

#Preview {
    StandingsView()
}
