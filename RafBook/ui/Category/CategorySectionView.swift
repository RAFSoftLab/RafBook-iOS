//
//  CategorySectionView.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 25.2.25..
//
import SwiftUI

struct CategorySectionView: View {
    let category: CategoryDTO

    var body: some View {
        Section(header: Text(category.name)) {
            ForEach(category.textChannels) { channel in
                NavigationLink(destination: TextChannelView(channel: channel)) {
                    Text(channel.name)
                        .padding(.leading, 20)
                }
            }
        }
    }
}

