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
                ForEach(table, id: \.self) { row in
                    
                }
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
