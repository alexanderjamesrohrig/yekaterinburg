//
//  MediumNextGameView.swift
//  yekaterinburg
//
//  Created by Alexander Rohrig on 10/16/23.
//

import SwiftUI
import WidgetKit

struct MediumNextGameView: View {
    
    @AppStorage("settingTeamID") private var favoriteTeamID = 117
    var entry: GameEntry
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MediumNextGameView()
}
