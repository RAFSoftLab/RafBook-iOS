import Foundation

struct LoginUIState{
    
}

@MainActor
@Observable
final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var errorMessage: String? = nil
    var isLoggingIn: Bool = false
    var loggedIn: Bool = false
    
    @ObservationIgnored
    let loginRepository: LoginRepository
    
    init(loginRepository: LoginRepository = AppContainer.shared.container.resolve(LoginRepository.self)!) {
        self.loginRepository = loginRepository
    }
    
    func login(appState: AppState) {
        guard validateInput() else { return }
        sanitazeInput()
        
        isLoggingIn = true
        errorMessage = nil
        
        let loginRequest = LoginRequestDTO(username: email, password: password)
        
        Task {
            do {
                let response = try await loginRepository.login(request: loginRequest)
                
                print("Login successful! Token: \(response.token)")
                self.loggedIn = true
                appState.isLoggedIn = true
                appState.currentScreen = .mainApp
                
            } catch {
                print("Login failed: \(error.localizedDescription)")
                self.errorMessage = "Invalid email or password."
            }
            self.isLoggingIn = false
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
