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

    public enum Action {
        case increment
        case incrementDebounced
        case decrement
        case decrementDebounced
        case asyncIncrement
        case asyncIncrementResponse
        case stepChanged(Int)
    }

    public init() { }

    public var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .increment:
                return .send(.incrementDebounced)
                    .debounce(
                        id: DebounceKind.increment,
                        for: .milliseconds(200),
                        scheduler: DispatchQueue.main
                    )

            case .incrementDebounced:
                state.count += state.stepValue
                return .none

            case .decrement:
                return .send(.decrementDebounced)
                    .debounce(
                        id: DebounceKind.decrement,
                        for: .milliseconds(200),
                        scheduler: DispatchQueue.main
                    )

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
