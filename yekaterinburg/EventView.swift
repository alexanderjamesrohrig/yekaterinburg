//
//  EventView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 2/19/24.
//

import SwiftUI

struct EventView: View {
    
    let game: Game
    let compact: Bool
    
    var body: some View {
        HStack {
            Text(game.homeTeamName)
            Spacer()
            if compact {
                Text(DateAdapter.yeFormatWithTime(from: game.date))
                    .foregroundStyle(.gray)
            } else {
                if game.televisionOptions.isEmpty {
                    Label("No TV options", systemImage: ImageManager.shared.noTV)
                        .labelStyle(.iconOnly)
                } else {
                    Label(game.televisionOptions, systemImage: ImageManager.shared.tv)
                }
                if !game.radioOptions.isEmpty {
                    Label(game.radioOptions, systemImage: ImageManager.shared.radio)
                }
                Text(game.date, style: .relative)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    EventView(game: Game.blankEvent, compact: false)
}
