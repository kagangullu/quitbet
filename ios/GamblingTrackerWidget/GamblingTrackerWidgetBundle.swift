//
//  GamblingTrackerWidgetBundle.swift
//  GamblingTrackerWidget
//
//  Created by Oğuz Kağan on 21.02.2025.
//

import WidgetKit
import SwiftUI

@main
struct GamblingTrackerWidgetBundle: WidgetBundle {
    var body: some Widget {
        GamblingTrackerWidget()
        GamblingTrackerWidgetControl()
        GamblingTrackerWidgetLiveActivity()
    }
}
