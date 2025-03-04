//
//  IsMyMessageUseCase.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 1.3.25..
//

protocol IsMyMessageUseCase {
    func isMyMessage(message: MessageDTO) -> Bool
}

final class IsMyMessageUseCaseImpl: IsMyMessageUseCase {
    private var loginRepository: LoginRepository
    
    init() {
        self.loginRepository = AppContainer.shared.container.resolve(LoginRepository.self)!
    }
    
    func isMyMessage(message: MessageDTO) -> Bool {
        loginRepository.loggedInUser?.id == message.sender.id
    }
    
}
