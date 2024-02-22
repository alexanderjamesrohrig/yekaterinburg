//
//  SmallNextGameTwoView.swift
//  ios-widgetExtension
//
//  Created by Alexander Rohrig on 9/24/23.
//

import SwiftUI
import UIKit
import WidgetKit

struct SmallNextGameTwoView: View {
    
    @AppStorage("settingTeamID") private var favoriteTeamID = 117
    var entry: GameEntry
    
    var body: some View {
        VStack {
            Text("\(entry.game.status)")
            HStack {
                Spacer()
                Text("\(entry.game.awayTeamCode)")
                    .font(.title)
                    .fontWeight(.heavy)
                    .fontWidth(.compressed)
                    .textCase(.uppercase)
                Divider()
                Text("\(entry.game.homeTeamCode)")
                    .font(.title)
                    .fontWeight(.heavy)
                    .fontWidth(.compressed)
                    .textCase(.uppercase)
                Spacer()
            }
            HStack {
                Text("Updated \(entry.lastUpdate.formatted(date: .omitted, time: .shortened))")
                Spacer()
                Text(entry.date, style: .time)
            }
            .font(.caption2)
        }
        .containerBackground(for: .widget) {
            Color(uiColor: UIColor.systemBackground)
        }
    }
}

//#Preview {
//    SmallNextGameViewTwo(entry: sampleGameTimelineEntry)
//        .previewContext(WidgetPreviewContext(family: .systemSmall))
//        .previewDisplayName("Next Game View 2.0")
//}
