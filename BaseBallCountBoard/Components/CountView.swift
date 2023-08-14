//
//  CountView.swift
//  BaseBallCountBoard
//
//  Created by 野瀬 玲 on 2023/08/08.
//

import SwiftUI

struct CountView: View {
    let type: CountTypeProtocol
    var color: Color {
        switch type {
        case is InningFeature.State.Ball:
            return Color(R.color.ballCount()!)
        case is InningFeature.State.Strike:
            return Color(R.color.strikeCount()!)
        case is InningFeature.State.Out:
            return Color(R.color.outCount()!)
        default:
            return Color(R.color.emptyCount()!)
        }
    }

    var body: some View {
        HStack {
            Text(type.displayText)
                .font(.largeTitle)
                .bold()
                .frame(width: 44, height: 44)

            ForEach(0..<type.maxCount, id: \.self) { i in
                let color = i < type.count ? color : Color(R.color.emptyCount()!)
                Circle()
                    .fill(color)
                    .frame(width: 44, height: 44)
            }
            Spacer()
                .frame(width: 8)
        }
    }
}

struct BallCountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CountView(type: InningFeature.State.Ball(count: 0))
            CountView(type: InningFeature.State.Ball(count: 1))
            CountView(type: InningFeature.State.Ball(count: 2))
            CountView(type: InningFeature.State.Ball(count: 3))
            CountView(type: InningFeature.State.Strike(count: 0))
            CountView(type: InningFeature.State.Strike(count: 1))
            CountView(type: InningFeature.State.Strike(count: 2))
            CountView(type: InningFeature.State.Out(count: 0))
            CountView(type: InningFeature.State.Out(count: 1))
            CountView(type: InningFeature.State.Out(count: 2))
        }
    }
}
