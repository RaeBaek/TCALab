//
//  CounterView.swift
//  Counter
//
//  Created by 백래훈 on 12/5/25.
//

import ComposableArchitecture
import SwiftUI
import Counter

@main
struct TCALabApp: App {
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: Store(
                    initialState: CounterFeature.State(),
                    reducer: { CounterFeature() }
                )
            )
        }
    }
}
