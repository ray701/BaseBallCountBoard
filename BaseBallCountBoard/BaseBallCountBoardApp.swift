//
//  BaseBallCountBoardApp.swift
//  BaseBallCountBoard
//
//  Created by 野瀬 玲 on 2023/08/07.
//
import ComposableArchitecture
import SwiftUI

@main
struct BaseBallCountBoardApp: App {
    static let store = Store(
        initialState: Root.State(),
        reducer: { Root().signpost()._printChanges() }
    )
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Self.store.scope(
                    state: \.inning,
                    action: Root.Action.inningFeature
                )
            )
        }
    }
}
