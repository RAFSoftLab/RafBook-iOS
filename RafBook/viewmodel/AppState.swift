//
//  AppState.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 14.1.25..
//
import SwiftUI

class AppState: ObservableObject {
    enum CurrentScreen {
        case splash, login, mainApp
    }
    
    @Published var currentScreen: CurrentScreen = .splash
    @Published var isLoggedIn: Bool = false
}
