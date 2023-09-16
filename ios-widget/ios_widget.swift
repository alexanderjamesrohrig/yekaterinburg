//
//  ios_widget.swift
//  ios-widget
//
//  Created by Alexander Rohrig on 7/14/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        sampleEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = sampleEntry
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // TODO way for user to change team
        Task {
            var entries: [SimpleEntry] = []
            let currentDate = Date()
            guard let games = try? await Game.allFor(team: 117) else {
                return
            }
            for x in games {
                entries.append(SimpleEntry(date: x.date, teamID: 117, isHome: true, opponentName: "Anaheim", gameDateTime: x.date))
            }
            let nextUpdate = Calendar.autoupdatingCurrent.date(byAdding: DateComponents(day: 1), to: currentDate)!
            let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}

struct ios_widgetEntryView : View {
    @Environment(\.widgetFamily) private var family
    @Environment(\.colorScheme) private var colorScheme
    
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            if entry.isHome {
                Color.white
            }
            else {
                Color.gray
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("Next")
                    Spacer()
                    Image(systemName: "airplane.departure")
                }
                HStack {
                    Text(entry.opponentName)
                }.font(.headline)
                Spacer()
                HStack {
                    Text(entry.gameDateTime, style: .relative)
                }
            }.padding()
        }
    }
}

struct ios_widget: Widget {
    let kind: String = "ios_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ios_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Next Game")
        .description("Show your team's next game.")
    }
}

struct ios_widget_Previews: PreviewProvider {
    static var previews: some View {
        ios_widgetEntryView(entry: sampleEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
