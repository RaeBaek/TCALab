//
//  CounterFeature.swift
//  Counter
//
//  Created by 백래훈 on 12/5/25.
//

import XCTest
import ComposableArchitecture
@testable import Counter

final class CounterFeatureTests: XCTestCase {
    func test_IncrementDebounce() async {
        let clock = TestClock()

        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        // increment 액션 보내면 즉시 incrementDebounced가 실행되지 않고
        // debounce 타이머가 걸린 상태로 기다리게 됨
        await store.send(.increment)

        // 아직 incrementDebounced는 실행되지 않아야 함
        let currentValue = await store.state.count
        XCTAssertEqual(currentValue, 0)

        // 200ms 경과 → debounce fire
        await clock.advance(by: .milliseconds(200))

        await store.receive(.incrementDebounced) {
            $0.count += $0.stepValue
        }

        let stepValue = await store.state.stepValue
        let count = await store.state.count

        XCTAssertEqual(stepValue, 1)
        XCTAssertEqual(count, 1)
    }

    func test_DecrementDebounce() async {
        let clock = TestClock()

        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        await store.send(.decrement)

        let currentValue = await store.state.count
        XCTAssertEqual(currentValue, 0)

        // 200ms 진행
        await clock.advance(by: .milliseconds(200))

        await store.receive(.decrementDebounced) {
            $0.count -= $0.stepValue
        }

        let stepValue = await store.state.stepValue
        let count = await store.state.count

        XCTAssertEqual(stepValue, 1)
        XCTAssertEqual(count, -1)
    }

    func test_DebounceCancelsInFlight() async {
        let clock = TestClock()

        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        // 첫 번째 increment
        await store.send(.increment)

        // 100ms 진행 (아직 debounce 실행 X)
        await clock.advance(by: .milliseconds(100))

        // 다시 increment (이전 debounce cancel)
        await store.send(.increment)

        let currentValue = await store.state.count
        XCTAssertEqual(currentValue, 0)

        // 200ms 더 진행해야 최신 incrementDebounced fire
        await clock.advance(by: .milliseconds(200))

        await store.receive(.incrementDebounced) {
            $0.count += $0.stepValue
        }

        let stepValue = await store.state.stepValue
        let count = await store.state.count

        XCTAssertEqual(stepValue, 1)
        XCTAssertEqual(count, 1)
    }

    func test_AsyncIncrement() async {
        let clock = TestClock()

        let store = await TestStore(initialState: CounterFeature.State(stepValue: 3)) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        await store.send(.asyncIncrement) {
            $0.isLoading = true
        }

        // 1초 후 count가 3이 되어야함
        await clock.advance(by: .seconds(1))

        await store.receive(.asyncIncrementResponse) {
            $0.isLoading = false
            $0.count = $0.stepValue
        }

        let stepValue = await store.state.stepValue
        let count = await store.state.count

        XCTAssertEqual(stepValue, 3)
        XCTAssertEqual(count, 3)
    }
}
