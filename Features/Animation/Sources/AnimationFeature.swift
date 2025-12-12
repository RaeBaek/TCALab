//
//  AnimationFeature.swift
//  Animation
//
//  Created by 백래훈 on 12/5/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
public struct AnimationFeature {

    @ObservableState
    public struct State: Equatable {
        var isExpanded: Bool
        var showContent: Bool
        var scale: CGFloat
        var cornerRadius: CGFloat

        public init(
            isExpanded: Bool = false,
            showContent: Bool = false,
            scale: CGFloat = 1.0,
            cornerRadius: CGFloat = 20
        ) {
            self.isExpanded = isExpanded
            self.showContent = showContent
            self.scale = scale
            self.cornerRadius = cornerRadius
        }
    }

    public enum Action {
        case tapCard
        case close
        case contentAppear
        case contentDisappear
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tapCard:
                state.isExpanded = true
                return .run { send in
                    try await Task.sleep(nanoseconds: 180_000_000)
                    await send(.contentAppear)
                }

            case .contentAppear:
                state.showContent = true
                return .none

            case .close:
                state.showContent = false
                return .run { send in
                    try await Task.sleep(nanoseconds: 120_000_000)
                    await send(.contentDisappear)
                }

            case .contentDisappear:
                state.isExpanded = false
                return .none
            }
        }
    }
}
