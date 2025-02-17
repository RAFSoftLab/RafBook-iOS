//
//  ChannelsViewModel.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 8.12.24..
//
import Foundation

class ChannelsViewModel: ObservableObject {
    
    @Published var channels: [TextChannel] = []
    @Published var currentChannel: TextChannel?
    
    @MainActor
    func getAllAvailableChannels() async throws -> [TextChannel]{
        do {
            let channels: [TextChannel] = try await Requests()
                .setEndpoint("text-channel")
                .setMethod("GET")
                .addAuth()
                .execute()
            self.channels = channels
            print("Fetched channels: \(channels)")
        } catch {
            print("Error fetching channels: \(error)")
        }
        return channels
    }
    
    
    
}
