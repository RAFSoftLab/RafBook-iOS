//
//  ChannelsViewModel.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 20.2.25..
//
import Foundation

@MainActor
@Observable
final class ChannelsViewModel{
    
    @Published var channels: [TextChannelDTO] = []
    @Published var currentChannel: TextChannelDTO?
    
    @ObservationIgnored
    let channelsRepository: TextChannelRepository
    
    init(channelsRepository: TextChannelRepository = AppContainer.shared.container.resolve(TextChannelRepository.self)!) {
        self.channelsRepository = channelsRepository
    }
    
    func getAllAvailableChannels() async throws -> [TextChannelDTO]{
        do {
            let channels: [TextChannelDTO] = try await Requests()
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
