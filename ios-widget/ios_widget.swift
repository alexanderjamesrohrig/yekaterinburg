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
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, teamID: 117, isHome: false, opponentName: "Anaheim", gameDateTime: Date())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let teamID: Int
    //let teamLogo: String
    let isHome: Bool
    let opponentName: String
    let gameDateTime: Date
}

struct ios_widgetEntryView : View {
    @Environment(\.widgetFamily) private var family
    @Environment(\.colorScheme) private var colorScheme
    
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Next")
            HStack {
                Image(systemName: "airplane.departure")
                Text(entry.opponentName)
            }
            Text(entry.gameDateTime, style: .time)
        }.padding()
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
