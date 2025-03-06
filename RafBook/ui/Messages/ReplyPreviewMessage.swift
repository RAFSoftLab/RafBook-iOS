//
//  ReplyPreviewMessage.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 6.3.25..
//
import SwiftUI

struct ReplyPreviewMessage: View {
    let parentMessage: MessageDTO?
    let isMyMessage: Bool

    var body: some View {
        if let parentMessage = parentMessage{
            HStack(spacing: 4) {
                if isMyMessage {
                    Spacer()
                }
                if !isMyMessage {
                    Image(systemName: "arrowshape.turn.up.left")
                        .foregroundColor(.gray)
                }
                Text(parentMessage.content)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .padding(6)
                    .background(Color(.systemGray6))
                    .cornerRadius(6)
                if !isMyMessage {
                    Spacer()
                }

            }
        }
    }
}
