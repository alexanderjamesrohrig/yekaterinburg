//
//  macos_widget.swift
//  macos-widget
//
//  Created by Alexander Rohrig on 7/7/23.
//

import WidgetKit
import SwiftUI

// MARK: - Timeline
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
        
        entries.append(sampleEntry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - View

struct macos_widgetEntryView : View {
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
