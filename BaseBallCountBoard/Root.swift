//
//  Root.swift
//  BaseBallCountBoard
//
//  Created by 野瀬 玲 on 2023/08/16.
//

import ComposableArchitecture

struct Root: Reducer {
    struct State: Equatable {
        var inning = InningFeature.State()
    }

    enum Action {
        case onAppear
        case inningFeature(InningFeature.Action)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state = .init()
                return .none

            default:
                return .none
            }
        }

        Scope(state: \.inning, action: /Action.inningFeature) {
            InningFeature()
        }
    }
}
