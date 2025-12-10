//
//  CounterView.swift
//  Counter
//
//  Created by 백래훈 on 12/5/25.
//

import ComposableArchitecture
import SwiftUI
import TwoCounters
import Todos

@main
struct TCALabApp: App {
    var body: some Scene {
        WindowGroup {
            TodosView(
                store: Store(
                    initialState: TodosFeature.State(),
                    reducer: { TodosFeature() }
                )
            )
//            TwoCountersView(store: Store(
//                initialState: TwoCountersFeature.State(),
//                reducer: { TwoCountersFeature() })
//            )
        }
    }
}
