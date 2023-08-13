//
//  InningFeature.swift
//  BaseBallCountBoard
//
//  Created by 野瀬 玲 on 2023/08/08.
//

import ComposableArchitecture

protocol CountTypeProtocol {
    var count: Int { get }
    var maxCount: Int { get }
    var displayText: String { get }
    static func reset() -> Self
    func increment() -> Self
}

struct InningFeature: Reducer {
    struct State: Equatable {
        var inningType = InningType.top
        var ball = Ball(count: 0)
        var strike = Strike(count: 0)
        var out = Out(count: 0)

        enum InningType {
            case top // 表
            case bottom // 裏
            func toggle() -> Self {
                switch self {
                case .top:
                    return .bottom
                case .bottom:
                    return .top
                }
            }
        }

        struct Ball: CountTypeProtocol, Equatable {

            let count: Int
            let maxCount = 3
            let displayText = "B"

            static func reset() -> Ball {
                Self(count: 0)
            }

            init(count: Int) {
                guard count <= maxCount else {
                    self.count = maxCount
                    return
                }
                self.count = count
            }

            func increment() -> InningFeature.State.Ball {
                let count = (count + 1) % (maxCount + 1)
                return .init(count: count)
            }
        }

        struct Strike: CountTypeProtocol, Equatable {
            let count: Int
            let maxCount = 2
            let displayText = "S"

            static func reset() -> Strike {
                Self(count: 0)
            }

            init(count: Int) {
                guard count <= maxCount else {
                    self.count = maxCount
                    return
                }
                self.count = count
            }

            func increment() -> Strike {
                let count = (count + 1) % (maxCount + 1)
                return .init(count: count)
            }
        }

        struct Out: CountTypeProtocol, Equatable {
            let count: Int
            let maxCount = 2
            let displayText = "O"

            static func reset() -> Out {
                Self(count: 0)
            }

            init(count: Int) {
                guard count <= maxCount else {
                    self.count = maxCount
                    return
                }
                self.count = count
            }

            func increment() -> Out {
                let count = (count + 1) % (maxCount + 1)
                return .init(count: count)
            }
        }
    }

    enum Action {
        case ballButtonTapped
        case strikeButtonTapped
        case batterOutButtonTapped
        case runnerOutButtonTapped
        case foulButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .ballButtonTapped:
            state.ball = state.ball.increment()

            if state.ball.count == 0 {
                state.strike = State.Strike.reset()
            }
        case .strikeButtonTapped:
            state.strike = state.strike.increment()

            if state.strike.count == 0 {
                state.ball = State.Ball.reset()
                state.out = state.out.increment()
            }
        case .batterOutButtonTapped:
            state.out = state.out.increment()
            state.ball = State.Ball.reset()
            state.strike = State.Strike.reset()

            if state.out.count == 0 {
                state.inningType = state.inningType.toggle()
            }
        case .runnerOutButtonTapped:
            state.out = state.out.increment()

            if state.out.count == 0 {
                state.ball = State.Ball.reset()
                state.strike = State.Strike.reset()
                state.inningType = state.inningType.toggle()
            }
        case .foulButtonTapped:
            if state.strike.count < state.strike.maxCount {
                state.strike = state.strike.increment()
            }
        }

        return .none
    }
}
