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
import Animation

@main
struct TCALabApp: App {
    var body: some Scene {
        WindowGroup {
            AnimationView(
                store: Store(
                    initialState: AnimationFeature.State(),
                    reducer: { AnimationFeature() }
                )
            )
//            TodosView(
//                store: Store(
//                    initialState: TodosFeature.State(),
//                    reducer: { TodosFeature() }
//                )
//            )
//            TwoCountersView(store: Store(
//                initialState: TwoCountersFeature.State(),
//                reducer: { TwoCountersFeature() })
//            )
        }
    }
}
