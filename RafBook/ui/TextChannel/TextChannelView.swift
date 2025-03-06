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
    
    private var isMyMessageUseCase: IsMyMessageUseCase
    
    init(channel: TextChannelDTO){
        self.channel = channel
        self.viewModel = TextChannelViewModel(channel: channel)
        self.isMyMessageUseCase = AppContainer.shared.container.resolve(IsMyMessageUseCase.self)!
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                ChatMessageView(message: message)
                            }
                            BottomOffsetMarkerView()
                        }
                        .padding()
                    }
                    // Scroll to the bottom of the view
                    .onAppear {
                        if let last = viewModel.messages.last {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                    .onChange(of: viewModel.messages.count) { _ , _ in
                        if let last = viewModel.messages.last, isMyMessageUseCase.isMyMessage(message: last) {
                            withAnimation {
                                proxy.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }

                }
                
                HStack {
                    TextField("Type a message...", text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: 44)
                        .autocorrectionDisabled()
                    Button("Send") {
                        viewModel.sendMessage(messageText)
                        messageText = ""
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

