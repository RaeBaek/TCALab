//
//  TodosView.swift
//  Todos
//
//  Created by 백래훈 on 12/11/25.
//

import SwiftUI
import ComposableArchitecture

public struct TodoRowView: View {
    let store: StoreOf<TodoFeature>

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            HStack(spacing: 12) {
                Button {
                    viewStore.send(.toggleCompleted)
                } label: {
                    Image(systemName: viewStore.isCompleted ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 22))
                        .foregroundStyle(viewStore.isCompleted ? .blue : .gray)
                }

                TextField(
                    "Title",
                    text: viewStore.binding(
                        get: \.title,
                        send: TodoFeature.Action.titleChanged
                    )
                )
                .font(.system(size: 18))
                .foregroundStyle(viewStore.isCompleted ? .gray : .primary)
                .strikethrough(viewStore.isCompleted, color: .gray)
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
            .padding(.horizontal, 8)
        }
    }
}

public struct TodosView: View {
    let store: StoreOf<TodosFeature>

    public init(store: StoreOf<TodosFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                // 상단 입력창
                HStack {
                    TextField(
                        "New Todo",
                        text: viewStore.binding(
                            get: \.newTodoTitle,
                            send: TodosFeature.Action.newTitleChanged
                        )
                    )
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Button {
                        viewStore.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.blue)
                    }
                }
                .padding()

                List {
                    ForEachStore(
                        store.scope(
                            state: \.todos,
                            action: \.todo
                        )
                    ) { store in
                        TodoRowView(store: store)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                            .padding(.vertical, 4)
                    }
                    .onDelete { indexSet in
                        viewStore.send(.delete(indexSet))
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            }
            .padding(.top, 8)
            .background(Color(.systemGroupedBackground))
        }
    }
}
