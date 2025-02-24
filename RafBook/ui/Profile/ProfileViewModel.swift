import Foundation

@MainActor
@Observable
final class ProfileViewModel {
    
    @ObservationIgnored
    let loginRepository: LoginRepository
    
    init(loginRepository: LoginRepository = AppContainer.shared.container.resolve(LoginRepository.self)!) {
        self.loginRepository = loginRepository
    }
    
    var displayName: String {
        guard let user = loginRepository.loggedInUser else { return "John Doe" }
        return "\(user.firstName) \(user.lastName)"
    }
    
    var displayRole: String {
        guard let user = loginRepository.loggedInUser, !user.role.isEmpty else { return "Faculty Member" }
        return user.role.map { $0.capitalized }.joined(separator: ", ")
    }
}
