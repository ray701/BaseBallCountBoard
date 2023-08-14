//
//  ContentView.swift
//  BaseBallCountBoard
//
//  Created by 野瀬 玲 on 2023/08/07.
//
import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<InningFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) {  viewStore in
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    CountView(type: viewStore.ball)
                    CountView(type: viewStore.strike)
                    CountView(type: viewStore.out)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(R.color.boardBackGround()!))
                .cornerRadius(15)

                buttonAreaView(viewStore)
            }
        }
    }

    @ViewBuilder func buttonAreaView(_ viewStore: ViewStore<InningFeature.State, InningFeature.Action>) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                AppButton(
                    text: viewStore.ball.displayText,
                    color: Color(R.color.ballCount()!)
                ) {
                    viewStore.send(.ballButtonTapped)
                }

                AppButton(
                    text: viewStore.strike.displayText,
                    color: Color(R.color.strikeCount()!)
                ) {
                    viewStore.send(.strikeButtonTapped)
                }

                VStack(alignment: .leading, spacing: 8) {
                    AppButton(
                        text: "B",
                        color: Color(R.color.outCount()!)
                    ) {
                        viewStore.send(.batterOutButtonTapped)
                    }
                    AppButton(
                        text: "R",
                        color: Color(R.color.outCount()!)
                    ) {
                        viewStore.send(.runnerOutButtonTapped)
                    }
                }
            }

            AppButton(
                text: "F",
                color: Color(R.color.strikeCount()!)
            ) {
                viewStore.send(.foulButtonTapped)
            }

            AppButton(
                text: "U",
                color: .brown
            ) {
                viewStore.send(.undoButtonTapped)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: .init(
                initialState: InningFeature.State(),
                reducer: { InningFeature() }
            )
        )
    }
}
