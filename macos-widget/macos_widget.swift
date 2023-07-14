//
//  macos_widget.swift
//  macos-widget
//
//  Created by Alexander Rohrig on 7/7/23.
//

import WidgetKit
import SwiftUI

// MARK: - TIMELINE
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
            let entry = SimpleEntry(date: entryDate, teamID: 117, isHome: true, opponentName: "Anaheim", gameDateTime: Date())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - Model

struct SimpleEntry: TimelineEntry {
    let date: Date
    let teamID: Int
    //let teamLogo: String
    let isHome: Bool
    let opponentName: String
    let gameDateTime: Date
}

// MARK: - View

struct macos_widgetEntryView : View {
    @Environment(\.widgetFamily) private var family
    @Environment(\.colorScheme) private var colorScheme
    
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Image("ti_\(entry.teamID)")
            Text("Next")
            HStack{
                if entry.isHome {
                    Image(systemName: "baseball.diamond.bases")
                    Text(entry.opponentName)
                }
                else {
                    Image(systemName: "airplane.departure")
                }
            }
            Text(entry.gameDateTime, style: .date)
        }
    }
}

@main
struct macos_widget: Widget {
    let kind: String = "macos_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            macos_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("Next Game")
        .description("Show your team's next game.")
        .supportedFamilies([.systemSmall])
    }
}

// MARK: - Preview

struct macos_widget_Previews: PreviewProvider {
    static var previews: some View {
        macos_widgetEntryView(entry: sampleEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
