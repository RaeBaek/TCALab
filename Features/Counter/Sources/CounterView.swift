//
//  CounterView.swift
//  Counter
//
//  Created by 백래훈 on 12/5/25.
//

import ComposableArchitecture
import SwiftUI

public struct CounterView: View {

    let store: StoreOf<CounterFeature>

    public init(store: StoreOf<CounterFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                Text("Count: \(viewStore.count)")
                    .font(.largeTitle)

                Stepper(
                    "Step: \(viewStore.stepValue)",
                    value: viewStore.binding(
                        get: \.stepValue,
                        send: { .stepChanged($0) }
                    ),
                    in: 1...10
                )
                .padding(.horizontal, 30)

                HStack(spacing: 20) {
                    Button("-") {
                        viewStore.send(.decrement)
                    }
                    .font(.largeTitle)

                    Button("+") {
                        viewStore.send(.increment)
                    }
                    .font(.largeTitle)
                }

                Button {
                    viewStore.send(.asyncIncrement)
                } label: {
                    if viewStore.isLoading {
                        ProgressView()
                    } else {
                        Text("Async +\(viewStore.stepValue) (after 1s)")
                    }
                }
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding()
        }
    }
}
