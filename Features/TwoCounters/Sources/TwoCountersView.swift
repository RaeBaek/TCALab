//
//  TwoCountersView.swift
//  TwoCounters
//
//  Created by 백래훈 on 12/9/25.
//

import SwiftUI
import ComposableArchitecture
import Counter

public struct TwoCountersView: View {
    let store: StoreOf<TwoCountersFeature>

    public init(store: StoreOf<TwoCountersFeature>) {
        self.store = store
    }

    public var body: some View {
        VStack(spacing: 24) {
            Text("Two Counters")
                .font(.largeTitle)

            // Counter 1
            CounterView(
                store: store.scope(
                    state: \.counter1,
                    action: \.counter1
                )
            )

            // Counter 2
            CounterView(
                store: store.scope(
                    state: \.counter2,
                    action: \.counter2
                )
            )

            Button("Reset All") {
                store.send(.resetAll)
            }
            .padding(.top, 32)

            Spacer()
        }
        .padding()
    }
}
