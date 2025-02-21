//
//  GamblingTrackerWidgetLiveActivity.swift
//  GamblingTrackerWidget
//
//  Created by Oğuz Kağan on 21.02.2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct GamblingTrackerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct GamblingTrackerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: GamblingTrackerWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension GamblingTrackerWidgetAttributes {
    fileprivate static var preview: GamblingTrackerWidgetAttributes {
        GamblingTrackerWidgetAttributes(name: "World")
    }
}

extension GamblingTrackerWidgetAttributes.ContentState {
    fileprivate static var smiley: GamblingTrackerWidgetAttributes.ContentState {
        GamblingTrackerWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: GamblingTrackerWidgetAttributes.ContentState {
         GamblingTrackerWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: GamblingTrackerWidgetAttributes.preview) {
   GamblingTrackerWidgetLiveActivity()
} contentStates: {
    GamblingTrackerWidgetAttributes.ContentState.smiley
    GamblingTrackerWidgetAttributes.ContentState.starEyes
}
