//
//  MessageBubble.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 6.3.25..
//

import SwiftUI

struct MessageBubble: View {
    let message: MessageDTO
    let isMyMessage: Bool

    var body: some View {
        Group {
            if isMyMessage {
                // Outgoing message: aligned right.
                HStack {
                    Spacer(minLength: 40)
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(message.content)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(8)
                        Text(message.createdAt)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal)
            } else {
                // Incoming message: aligned left with avatar and sender name.
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                        .padding(.top, 2)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.sender.username)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        Text(message.content)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(10)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                        Text(message.createdAt)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.vertical, 6)
                .padding(.horizontal)
            }
        }
    }
}
