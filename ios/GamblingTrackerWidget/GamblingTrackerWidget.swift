import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), days: 0, hours: 0, minutes: 0, seconds: 0, progress: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.com.example.quitbet")
        let startTimeMs = userDefaults?.integer(forKey: "abstinence_start_time") ?? 0
        
        if startTimeMs == 0 {
            let entry = SimpleEntry(date: Date(), days: 0, hours: 0, minutes: 0, seconds: 0, progress: 0)
            completion(entry)
            return
        }
        
        let startDate = Date(timeIntervalSince1970: TimeInterval(startTimeMs / 1000))
        let difference = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: startDate, to: Date())
        
        let days = difference.day ?? 0
        let progress = min(days * 100 / 90, 100)
        
        let entry = SimpleEntry(
            date: Date(),
            days: days,
            hours: difference.hour ?? 0,
            minutes: difference.minute ?? 0,
            seconds: difference.second ?? 0,
            progress: progress
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    let currentDate = Date()
    
    getSnapshot(in: context) { entry in
        entries.append(entry)
        
        for minuteOffset in 1...30 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            getSnapshot(in: context) { nextEntry in
                var updatedEntry = nextEntry
                updatedEntry.date = entryDate
                entries.append(updatedEntry)
            }
        }
        
        let refreshTime = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
        let timeline = Timeline(entries: entries, policy: .after(refreshTime))
        completion(timeline)
    }
}
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let days: Int
    let hours: Int
    let minutes: Int
    let seconds: Int
    let progress: Int
}

struct GamblingTrackerWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.05, green: 0.06, blue: 0.22),
                Color(red: 0.10, green: 0.12, blue: 0.38)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var mainText: Text {
        if entry.days > 0 {
            return Text("\(entry.days)")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        } else if entry.hours > 0 {
            return Text("\(entry.hours)")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        } else if entry.minutes > 0 {
            return Text("\(entry.minutes)")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        } else {
            return Text("\(entry.seconds)")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
    
    var mainUnit: Text {
        if entry.days > 0 {
            return Text("days")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
        } else if entry.hours > 0 {
            return Text("hr")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
        } else if entry.minutes > 0 {
            return Text("m")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
        } else {
            return Text("s")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
        }
    }
    
    var secondaryText: Text? {
        if entry.days > 0 {
            return Text("\(entry.hours)s \(entry.minutes)d \(entry.seconds)s")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.6))
        } else if entry.hours > 0 {
            return Text("\(entry.minutes)d \(entry.seconds)s")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.6))
        } else if entry.minutes > 0 {
            return Text("\(entry.seconds)s")
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.6))
        }
        return nil
    }

   var body: some View {
    if #available(iOS 17.0, *) {
        VStack(spacing: 6) {
            Text("QUITBET")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
                .padding(.bottom, 4)
            
            HStack(alignment: .firstTextBaseline, spacing: 3) {
                mainText
                mainUnit
            }
            
            if let secondaryText = secondaryText {
                secondaryText
                    .padding(.top, 1)
            }
            
            if widgetFamily != .systemSmall {
                Spacer()
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 0.0, green: 0.8, blue: 0.7))
                        .frame(width: max(4, CGFloat(entry.progress) / 100.0 * (widgetFamily == .systemMedium ? 270 : 120)), height: 8)
                }
                
                Text("Brain recovering: %\(entry.progress)")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.top, 4)
            }
        }
        .padding()
        .containerBackground(for: .widget) {
            gradient
                .overlay(
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 140, height: 140)
                        .blur(radius: 20)
                        .offset(x: 70, y: -50)
                )
        }
    } else {
        ZStack {
            gradient
                .overlay(
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 140, height: 140)
                        .blur(radius: 20)
                        .offset(x: 70, y: -50)
                )
            
            VStack(spacing: 6) {
                Text("QUITBET")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.bottom, 4)
                
                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    mainText
                    mainUnit
                }
                
                if let secondaryText = secondaryText {
                    secondaryText
                        .padding(.top, 1)
                }
                
                if widgetFamily != .systemSmall {
                    Spacer()
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(0.1))
                            .frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(red: 0.0, green: 0.8, blue: 0.7))
                            .frame(width: max(4, CGFloat(entry.progress) / 100.0 * (widgetFamily == .systemMedium ? 270 : 120)), height: 8)
                    }
                    
                    Text("Brain recovering: %\(entry.progress)")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.top, 4)
                }
            }
            .padding()
        }
    }
}
}

struct GamblingTrackerWidget: Widget {
    let kind: String = "GamblingTrackerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Link(destination: URL(string: "quitgambling://widget/refresh")!) {
                GamblingTrackerWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("QUITBET")
        .description("It shows how long ago you stopped gambling.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
struct GamblingTrackerWidget_Previews: PreviewProvider {
    static var previews: some View {
        GamblingTrackerWidgetEntryView(entry: SimpleEntry(date: Date(), days: 14, hours: 3, minutes: 45, seconds: 20, progress: 15))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        GamblingTrackerWidgetEntryView(entry: SimpleEntry(date: Date(), days: 14, hours: 3, minutes: 45, seconds: 20, progress: 15))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}