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
        initialState: InningFeature.State(),
        reducer: { InningFeature() }
    )
    var body: some Scene {
        WindowGroup {
            ContentView(store: BaseBallCountBoardApp.store)
        }
    }
}
