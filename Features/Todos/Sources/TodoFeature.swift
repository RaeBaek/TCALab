//
//  TodoFeature.swift
//  Todos
//
//  Created by 백래훈 on 12/5/25.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct TodoFeature {

    @ObservableState
    public struct State: Equatable, Identifiable {
        public let id: UUID
        public var title: String
        public var isCompleted: Bool

        public init(
            id: UUID = UUID(),
            title: String,
            isCompleted: Bool = false
        ) {
            self.id = id
            self.title = title
            self.isCompleted = isCompleted
        }
    }

    public enum Action: Equatable {
        case titleChanged(String)
        case toggleCompleted
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .titleChanged(let newTitle):
                state.title = newTitle
                return .none

            case .toggleCompleted:
                state.isCompleted.toggle()
                return .none
            }
        }
    }
}
