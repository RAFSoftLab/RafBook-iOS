//
//  SplashScreen.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 26.11.24..
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("raf_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
