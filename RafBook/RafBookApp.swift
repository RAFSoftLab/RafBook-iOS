//
//  RafBookApp.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 19.11.24..
//

import SwiftUI

@main
struct RafBookApp: App {
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appState)
        }
    }
}
