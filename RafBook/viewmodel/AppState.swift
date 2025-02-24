//
//  AppState.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 14.1.25..
//
import SwiftUI
import Foundation

@Observable
class AppState: ObservableObject {
    enum CurrentScreen {
        case splash, login, mainApp
    }
    
    var currentScreen: CurrentScreen = .splash
    var isLoggedIn: Bool = false
    var user: UserDTO?
}
