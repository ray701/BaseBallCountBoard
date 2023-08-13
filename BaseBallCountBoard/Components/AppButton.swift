//
//  AppButton.swift
//  BaseBallCountBoard
//
//  Created by 野瀬 玲 on 2023/08/10.
//

import SwiftUI

struct AppButton: View {
    let text: String
    let color: Color
    let action: @MainActor () -> Void

    init(
        text: String,
        color: Color,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.color = color
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(
                    Circle()
                        .fill(color)
                )
        }
    }
}

struct BallButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(text: "B", color: Color(R.color.ballCount()!)) {
            NSLog("ボタン押したよ")
        }
    }
}
