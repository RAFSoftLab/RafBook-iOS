//
//  ContentView.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 19.11.24..
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    
    var body: some View {
        Group {
            if showSplash {
                SplashScreenView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
