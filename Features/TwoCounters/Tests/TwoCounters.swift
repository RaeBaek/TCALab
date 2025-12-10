//
//  CounterFeature.swift
//  Counter
//
//  Created by 백래훈 on 12/5/25.
//

import XCTest
import ComposableArchitecture
@testable import Counter
@testable import TwoCounters

final class TwoCountersFeatureTests: XCTestCase {
    func test_ResetAll() async {
        let store = await TestStore(initialState: TwoCountersFeature.State()) {
            TwoCountersFeature()
        }

        await store.send(.counter1(.incrementDebounced)) {
            $0.counter1.count = $0.counter1.stepValue
        }

        await store.send(.counter2(.incrementDebounced)) {
            $0.counter2.count = $0.counter2.stepValue
        }

        let counter1Value = await store.state.counter1.count
        let counter2Value = await store.state.counter2.count

        XCTAssertEqual(counter1Value, 1)
        XCTAssertEqual(counter2Value, 1)

        await store.send(.resetAll) {
            $0.counter1.count = 0
            $0.counter2.count = 0
        }

        let counter1Reset = await store.state.counter1.count
        let counter2Reset = await store.state.counter2.count

        XCTAssertEqual(counter1Reset, 0)
        XCTAssertEqual(counter2Reset, 0)
    }
}
