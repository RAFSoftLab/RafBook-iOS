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
    
    init(channel: TextChannelDTO) {
        self.channel = channel
        self.messages = channel.messageDTOList // Use initial messages or load them later
    }
    
    // Add functions to load new messages, send messages, etc.
    func loadMoreMessages() async {
        // e.g. fetch older messages and prepend them to messages.
    }
    
    func sendMessage(_ text: String) async {
        // Call repository to send a message, then update messages array.
    }
}
