//
//  MainView.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 8.12.24..
//
import SwiftUI

struct NavigationTabsView: View {
    var body: some View {
        TabView {
            ChannelsView()
                .tabItem {
                    Label("Channels", systemImage: "bubble.left.and.bubble.right")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview{
    NavigationTabsView()
}
