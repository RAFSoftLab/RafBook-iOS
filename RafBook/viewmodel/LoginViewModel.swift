import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoggingIn: Bool = false
    @Published var loggedIn: Bool = false
    
    func login(appState: AppState) {
        guard validateInput() else { return }
        sanitazeInput()
        
        isLoggingIn = true
        errorMessage = nil
        
        // Prepare login request payload
        let loginRequest = LoginRequest(username: email, password: password)
        
        APIClient.shared.request(
            endpoint: "users/auth/login",
            method: "POST",
            body: loginRequest
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoggingIn = false
                
                switch result {
                case .success(let data):
                    do {
                        // Decode the login response
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        
                        // Save the token to Keychain
                        KeychainManager.saveTokenToKeychain(token: loginResponse.token)
                        print(loginResponse.token)
                        print("Login successful!")
                        self.loggedIn = true
                        appState.isLoggedIn = true
                        appState.currentScreen = .mainApp
                    } catch {
                        print("Failed to decode response: \(error.localizedDescription)")
                        self.errorMessage = "An error occurred. Please try again."
                    }
                    
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
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
        
        return true
    }
    
    private func sanitazeInput() {
        email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        password = password.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
