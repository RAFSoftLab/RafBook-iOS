//
//  TextChannelViewModel.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 1.3.25..
//

import SwiftUI

@MainActor
@Observable
final class TextChannelViewModel {
    let channel: TextChannelDTO
    var messages: [MessageDTO]
    let sendNewMessageUseCase: SendNewMessageUseCase
    
    init(channel: TextChannelDTO) {
        self.channel = channel
        self.messages = channel.messageDTOList.sorted { $0.createdAt < $1.createdAt }
        self.sendNewMessageUseCase = AppContainer.shared.container.resolve(SendNewMessageUseCase.self)!
    }
    
    // Add functions to load new messages, send messages, etc.
    func loadMoreMessages() async {
        // e.g. fetch older messages and prepend them to messages.
    }
    
    func sendMessage(_ text: String){
        Task{
            do{
                let sentMessage = try await sendNewMessageUseCase.sendTextMessage(to: channel, content: text)
                messages.append(sentMessage)
            } catch {
                print(error)
            }
        }
    }
}
