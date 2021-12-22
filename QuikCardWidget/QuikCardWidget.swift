//
//  QuikCardWidget.swift
//  QuikCardWidget
//
//  Created by Terence Williams on 9/1/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct QuikEntry: TimelineEntry {
    var date: Date
    var image: UIImage
}

struct QuikCardWidgetEntryView : View {
    public var url: String
    private let placeholderImage = UIImage(named: "QuikCard1024.jpg") ?? UIImage()

    @State private var qrImage: UIImage?

    var body: some View {
        Image(uiImage: placeholderImage).resizable()
    }
}

@main
struct QuikCardWidget: Widget {
    let kind: String = "QuikCardWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            QuikCardWidgetEntryView(url: UserDefaults.standard.value(forKey: "linkedin") as! String)
        }
        .configurationDisplayName("Quik Card Widget")
        .description("Quick access to your highlighted link.")
    }
}

struct QuikCardWidget_Previews: PreviewProvider {
    static var previews: some View {
        QuikCardWidgetEntryView(url: UserDefaults.standard.value(forKey: "linkedin") as! String)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
