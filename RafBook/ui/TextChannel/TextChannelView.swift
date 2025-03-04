//
//  TextChannel.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 1.3.25..
//

import SwiftUI


struct TextChannelView: View {
    let channel: TextChannelDTO

    @State private var tabBarHidden = true
    @State private var viewModel: TextChannelViewModel
    @State private var messageText: String = ""
    
    init(channel: TextChannelDTO){
        self.channel = channel
        self.viewModel = TextChannelViewModel(channel: channel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            ChatMessageView(message: message)
                        }
                    }
                    .padding()
                }
                
                // Optional: an input field with a "Send" button at the bottom
                HStack {
                    TextField("Type a message...", text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: 44)
                        .autocorrectionDisabled()
                    Button("Send") {
                        viewModel.sendMessage(messageText)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                tabBarHidden = true
            }
            .onDisappear {
                tabBarHidden = false
            }
            .toolbar(tabBarHidden ? .hidden : .visible, for: .tabBar)

            
        }
        
    }
}

