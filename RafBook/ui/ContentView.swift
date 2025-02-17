//
//  ContentView.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 19.11.24..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            switch appState.currentScreen {
            case .splash:
                SplashScreenView()
            case .login:
                LoginView()
            case .mainApp:
                MainView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    appState.currentScreen = .login
                }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AppState())
}
