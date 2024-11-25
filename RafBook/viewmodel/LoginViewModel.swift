//
//  LoginViewModel.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 26.11.24..
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoggingIn: Bool = false
    
    func login() {
        guard validateInput() else { return }
        
        sanitazeInput()
        
        // FAKE LOGIN
        isLoggingIn = true
        errorMessage = nil
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.isLoggingIn = false
                if self.email == "stevan@raf.rs" && self.password == "sifra" {
                    print("Login successful!")
                } else {
                    self.errorMessage = "Invalid email or password."
                }
            }
        }
    }
    
    private func validateInput() -> Bool {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        if !email.contains("@") {
            errorMessage = "Invalid email format."
            return false
        }
        
        return true
    }
    
    private func sanitazeInput() {
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        password = password.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
