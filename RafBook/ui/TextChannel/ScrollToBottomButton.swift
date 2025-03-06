//
//  ScrollToBottomButton.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 6.3.25..
//

import SwiftUI

struct ScrollToBottomButton: View {
    let proxy: ScrollViewProxy
    let lastMessageId: AnyHashable

    var body: some View {
        Button(action: {
            withAnimation {
                proxy.scrollTo(lastMessageId, anchor: .bottom)
            }
        }) {
            Image(systemName: "arrow.down.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
                .padding()
        }
        .transition(.scale)
    }
}

struct BottomOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - BottomOffsetMarkerView
/// An invisible view that reports its global minY using a preference.
/// Place this at the bottom of a ScrollView's content to determine
/// if the bottom is off-screen.
struct BottomOffsetMarkerView: View {
    var body: some View {
        Color.clear
            .frame(height: 1)
            .background(
                GeometryReader { geo in
                    Color.clear.preference(
                        key: BottomOffsetPreferenceKey.self,
                        value: geo.frame(in: .global).minY
                    )
                }
            )
    }
}

