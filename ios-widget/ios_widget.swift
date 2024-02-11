//
//  ios_widget.swift
//  ios-widget
//
//  Created by Alexander Rohrig on 7/14/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> GameEntry {
        sampleGameTimelineEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (GameEntry) -> ()) {
        let entry = sampleGameTimelineEntry
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<GameEntry>) -> ()) {
        // TODO way for user to change team, chosen method is user default suite
        Task {
            var entries: [GameEntry] = []
            let currentDate = Date.now
            guard let games = try? await Game.gamesFor(team: 117, forDate: currentDate) else {
                return
            }
            for x in games {
                print(x)
                entries.append(GameEntry(game: x))
            }
            let nextUpdate = Calendar.autoupdatingCurrent.date(byAdding: DateComponents(hour: 1), to: currentDate)!
            let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}

struct ios_widgetEntryView : View {
    
    @Environment(\.widgetFamily) private var widgetFamily
//    @Environment(\.widgetRenderingMode) private var widgetRenderingMode // Vibrant on Lockscreen
//    @Environment(\.showsWidgetContainerBackground) var showsWidgetContainerBackground // False if in Standy Mode
    
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            if Date.now > entry.game.date {
                SmallGameInProgressView(entry: entry)
            } else {
                SmallNextGameViewTwo(entry: entry)
            }
        case .systemMedium:
            MediumNextGameView(entry: entry)
        case .accessoryInline:
            InlineNextGameView(entry: entry)
        case .accessoryCircular:
            CircularNextGameView(entry: entry)
        default:
            EmptyView()
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
        .supportedFamilies([.systemSmall,
                            .systemMedium,
                            .accessoryInline,
                            .accessoryCircular,])
    }
}

struct ios_widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallGameInProgressView(entry: sampleGameTimelineEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("In Progress - Small")
            SmallNextGameViewTwo(entry: sampleGameTimelineEntry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName("Next Game 2.0 - Small")
            MediumNextGameView(entry: sampleGameTimelineEntry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDisplayName("Next Game 3.0 - Medium")
            InlineNextGameView(entry: sampleGameTimelineEntry)
                .previewContext(WidgetPreviewContext(family: .accessoryInline))
                .previewDisplayName("Next Game - Inline")
            CircularNextGameView(entry: sampleGameTimelineEntry)
                .previewContext(WidgetPreviewContext(family: .accessoryCircular))
                .previewDisplayName("Next Game - Circular")
        }
    }
}
