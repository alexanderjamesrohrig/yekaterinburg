//
//  AddScheduledGame.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/16/24.
//

import SwiftUI

struct AddScheduledGameView: View {
    
    @State private var game = Game()
    
    var body: some View {
        Form {
            Section("Home") {
                TextField("Name", text: $game.homeTeamName)
            }
            Section("Away") {
                TextField("Name", text: $game.awayTeamName)
            }
            Section("Details") {
                Picker("Sport", selection: $game.type) {
                    Text("Basketball").tag(YeType.game(.basketball))
                    Text("College Football").tag(YeType.game(.collegeFootball))
                    Text("Baseball").tag(YeType.game(.baseball))
                    Text("Hockey").tag(YeType.game(.hockey))
                    Text("Calcio (Soccer)").tag(YeType.game(.calcio))
                    Text("Stand Alone Event").tag(YeType.event)
                }
                TextField("Status", text: $game.status)
                DatePicker("Date & Time", selection: $game.date)
                TextField("Venue", text: $game.venue)
                TextField("Television", text: $game.televisionOptions)
                TextField("Radio", text: $game.radioOptions)
            }
        }
        .padding()
        Button("Manually Add Game") {
            
        }
        .buttonStyle(.bordered)
        .padding()
    }
}

#Preview {
    AddScheduledGameView()
}
