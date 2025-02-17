//
//  ChannelView.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 8.12.24..
//

import SwiftUI

struct ChannelView: View {
    @State private var messages: [String] = [
        "Welcome to the channel!",
        "This is the first message.",
        "Feel free to share your thoughts."
    ]
    @State private var newMessage: String = "" // Text input for new messages

    var body: some View {
        VStack {
            // Scrollable list of messages
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(messages, id: \.self) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding()
                }
                .onChange(of: messages) { _ in
                    // Scroll to the latest message when a new one is added
                    if let lastMessage = messages.last {
                        withAnimation {
                            scrollView.scrollTo(lastMessage, anchor: .bottom)
                        }
                    }
                }
            }

            // Text input and Send button
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button(action: sendMessage) {
                    Text("Send")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .disabled(newMessage.isEmpty) // Disable send button if no message
                .padding(.trailing)
            }
            .padding()
        }
        .navigationTitle("Channel Name") // Replace with the actual channel name
    }

    // Function to handle sending a new message
    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        messages.append(newMessage)
        newMessage = "" // Clear the text box
    }
}

// Custom view for displaying individual messages
struct MessageBubble: View {
    let message: String

    var body: some View {
        HStack {
            Text(message)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            Spacer()
        }
    }
}

#Preview {
    ChannelView()
}
