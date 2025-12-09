//
//  CounterFeature.swift
//  Counter
//
//  Created by 백래훈 on 12/5/25.
//

import Combine
import ComposableArchitecture
import SwiftUI

@Reducer
public struct CounterFeature {
    public struct State: Equatable {
        var count: Int
        var isLoading: Bool
        var stepValue: Int

        public init(
            count: Int = 0,
            isLoading: Bool = false,
            stepValue: Int = 1
        ) {
            self.count = count
            self.isLoading = isLoading
            self.stepValue = stepValue
        }
    }

    public enum Action: Equatable {
        case increment
        case incrementDebounced
        case decrement
        case decrementDebounced
        case asyncIncrement
        case asyncIncrementResponse
        case stepChanged(Int)
    }

    @Dependency(\.continuousClock) var clock

    public init() { }

    public var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .increment:
                return .run { send in
                    try await clock.sleep(for: .milliseconds(200))
                    await send(.incrementDebounced)
                }
                .cancellable(id: DebounceKind.increment, cancelInFlight: true)

            case .incrementDebounced:
                state.count += state.stepValue
                return .none

            case .decrement:
                return .run { send in
                    try await clock.sleep(for: .milliseconds(200))
                    await send(.decrementDebounced)
                }
                .cancellable(id: DebounceKind.decrement, cancelInFlight: true)

            case .decrementDebounced:
                state.count -= state.stepValue
                return .none

            case .asyncIncrement:
                guard !state.isLoading else { return .none }
                state.isLoading = true
                return .run { send in
                    try await Task.sleep(for: .seconds(1))
                    await send(.asyncIncrementResponse)
                }

            case .asyncIncrementResponse:
                state.isLoading = false
                state.count += state.stepValue
                return .none

            case .stepChanged(let newValue):
                state.stepValue = newValue
                return .none
            }
        }
    }
}

enum DebounceKind: Hashable, Sendable {
    case increment
    case decrement
}
