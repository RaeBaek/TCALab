//
//  AnimationView.swift
//  Animation
//
//  Created by 백래훈 on 12/12/25.
//

import ComposableArchitecture
import SwiftUI

public struct AnimationView: View {

    let store: StoreOf<AnimationFeature>

    @Namespace private var animationNS

    public init(store: StoreOf<AnimationFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                if viewStore.isExpanded {
                    expandedCard(viewStore)
                        .transition(
                            .asymmetric(
                                insertion: .opacity.animation(.easeIn(duration: 0.25)),
                                removal: .opacity.animation(.easeOut(duration: 0.2))
                            )
                        )
                } else {
                    collapsedCard(viewStore)
                        .transition(
                            .scale.animation(
                                .spring(
                                    response: 0.35,
                                    dampingFraction: 0.8
                                )
                            )
                        )
                }
            }
            .animation(.spring(response: 0.45, dampingFraction: 0.85), value: viewStore.isExpanded)
            .animation(.easeInOut(duration: 0.3), value: viewStore.showContent)
        }
    }

    // MARK: Collapsed card
    func collapsedCard(_ viewStore: ViewStore<AnimationFeature.State, AnimationFeature.Action>) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.blue)
            .matchedGeometryEffect(id: "card", in: animationNS)
            .frame(width: 180, height: 120)
            .overlay(
                Text("탭하여 확장")
                    .foregroundStyle(.white)
                    .font(.title3)
            )
            .onTapGesture {
                withAnimation {
                    _ = viewStore.send(.tapCard)
                }
            }
    }

    // MARK: Expanded card
    func expandedCard(_ viewStore: ViewStore<AnimationFeature.State, AnimationFeature.Action>) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.blue)
            .matchedGeometryEffect(id: "card", in: animationNS)
            .frame(maxWidth: .infinity, maxHeight: 420)
            .padding(.horizontal, 16)
            .overlay(
                VStack(spacing: 20) {
                    Spacer().frame(height: 20)

                    if viewStore.showContent {
                        Text("고급 TCA 애니메이션")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }

                    if viewStore.showContent {
                        Text("이 화면은 단계적으로 진행되는 애니메이션과 전환 효과, matched geometry, 그리고 reducer가 제어하는 지연 로직을 보여줍니다.")
                            .foregroundStyle(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .transition(.opacity.combined(with: .scale))
                    }

                    Spacer()

                    if viewStore.showContent {
                        Button {
                            withAnimation {
                                _ = viewStore.send(.close)
                            }
                        } label: {
                            Text("닫기")
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(Color.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .foregroundStyle(.white)
                        }
                        .transition(.opacity)
                    }
                    Spacer().frame(height: 40)
                }
                .padding(.horizontal, 16)
            )
            .onTapGesture {
                if viewStore.showContent == false {
                    withAnimation {
                        _ = viewStore.send(.tapCard)
                    }
                }
            }
    }
}
