//
//  CompetitionsView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 4/23/24.
//

import SwiftUI

struct CompetitionsView: View {
    
    @State private var competitions: [WorldFootballCompetitionsResponse.Competition] = []
    
    var body: some View {
        List(competitions) { competition in
            HStack {
                VStack(alignment: .leading) {
                    Text(competition.name ?? "")
                    Text(competition.code ?? "_")
                        .monospaced()
                }
                Spacer()
                Text(competition.plan ?? "")
            }
        }
        .task {
            let response = await WorldFootballAPI.competitions()
            competitions = response?.competitions ?? []
        }
    }
}

#Preview {
    CompetitionsView()
}
