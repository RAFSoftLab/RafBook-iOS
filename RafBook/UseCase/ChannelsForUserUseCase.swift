//
//  ChannelsForUserUsecase.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 20.2.25..
//

protocol ChannelsForUserUsecase {
    
}

final class ChannelsForUserUsecaseImpl: ChannelsForUserUsecase {
    private let textChannelRepository: TextChannelRepository
    private let loginRepository: LoginRepository
    
    init() {
        self.textChannelRepository = AppContainer.shared.container.resolve(TextChannelRepository.self)!
        self.loginRepository = AppContainer.shared.container.resolve(LoginRepository.self)!
    }
    
    func execute() async throws -> [TextChannelDTO] {
        
    }
}
