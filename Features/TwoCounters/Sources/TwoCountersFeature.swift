//
//  TwoCounterFeature.swift
//  TwoCounters
//
//  Created by 백래훈 on 12/5/25.
//

import ComposableArchitecture
import Counter

@Reducer
public struct TwoCountersFeature {
    public struct State: Equatable {
        var counter1: CounterFeature.State
        var counter2: CounterFeature.State

        public init() {
            self.counter1 = CounterFeature.State()
            self.counter2 = CounterFeature.State()
        }
    }

    public enum Action: Equatable {
        case counter1(CounterFeature.Action)
        case counter2(CounterFeature.Action)
        case resetAll
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.counter1, action: \.counter1) {
            CounterFeature()
        }
        Scope(state: \.counter2, action: \.counter2) {
            CounterFeature()
        }

        Reduce { state, action in
            switch action {
            case .resetAll:
                state.counter1 = CounterFeature.State()
                state.counter2 = CounterFeature.State()
                return .none

            case .counter1, .counter2:
                return .none
            }
        }
    }
}
