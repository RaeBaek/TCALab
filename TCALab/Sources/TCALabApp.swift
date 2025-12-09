//
//  CounterView.swift
//  Counter
//
//  Created by 백래훈 on 12/5/25.
//

import ComposableArchitecture
import SwiftUI
import TwoCounters

@main
struct TCALabApp: App {
    var body: some Scene {
        WindowGroup {
            TwoCountersView(store: Store(
                initialState: TwoCountersFeature.State(),
                reducer: { TwoCountersFeature() })
            )
        }
    }
}
