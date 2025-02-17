//
//  ChannelsView.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 8.12.24..
//

import SwiftUI

struct ChannelsView: View {
    
    @StateObject var viewModel = ChannelsViewModel()
    @State var channels: [TextChannel] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(channels) { channel in
                    Text(channel.name)
                }
            }
            .navigationTitle("Channels")
        }
        .task {
            do{
                channels = try await viewModel.getAllAvailableChannels()
            } catch {
                print("Failed to get channels \(error)")
            }
        }
    }
}

#Preview {
    ChannelsView()
}
