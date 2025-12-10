//
//  TodosFeature.swift
//  Todos
//
//  Created by 백래훈 on 12/10/25.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct TodosFeature {

    @ObservableState
    public struct State: Equatable {
        public var todos: IdentifiedArrayOf<TodoFeature.State>
        public var newTodoTitle: String

        public init(
            todos: IdentifiedArrayOf<TodoFeature.State> = [],
            newTodoTitle: String = ""
        ) {
            self.todos = todos
            self.newTodoTitle = newTodoTitle
        }
    }

    public enum Action: Equatable {
        case newTitleChanged(String)
        case addButtonTapped
        case delete(IndexSet)
        case todo(id: TodoFeature.State.ID, action: TodoFeature.Action)
    }

    public init() { }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            // 상단 TextField 입력
            case .newTitleChanged(let title):
                state.newTodoTitle = title
                return .none

            // + 버튼으로 Todo 추가
            case .addButtonTapped:
                let trimmed = state.newTodoTitle.trimmingCharacters(in: .whitespaces)
                guard trimmed.isEmpty == false else { return .none }

                state.todos.append(
                    TodoFeature.State(title: trimmed)
                )
                state.newTodoTitle = ""
                return .none

            // 스와이프 삭제
            case let .delete(indexSet):
                state.todos.remove(atOffsets: indexSet)
                return .none

            // 개별 Todo 액션 수동 처리
            case let .todo(id, childAction):
                guard let index = state.todos.index(id: id) else {
                    return .none
                }

                switch childAction {
                case .toggleCompleted:
                    state.todos[index].isCompleted.toggle()
                    return .none

                case let .titleChanged(newTitle):
                    state.todos[index].title = newTitle
                    return .none
                }
            }
        }
    }
}
