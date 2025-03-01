//
//  Conteiner.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 19.2.25..
//
import Swinject

final class AppContainer {
    static let shared = AppContainer()
    let container: Container

    private init() {
        container = Container()
        registerDependencies()
    }

    private func registerDependencies() {
        // Token provider
        container.register(TokenProvider.self) { _ in DefaultTokenProvider() }.inObjectScope(.container)
        
        // Network manager
        container.register(NetworkManager.self) { resolver in
            let tokenProvider = resolver.resolve(TokenProvider.self)!
            return NetworkManager(tokenProvider: tokenProvider)
        }.inObjectScope(.container)
        
        // Services
        container.register(NetworkService.self) { resolver in
            let networkManager = resolver.resolve(NetworkManager.self)!
            return NetworkServiceImpl(networkManager: networkManager)
        }.inObjectScope(.container)
        
        // Repositories
        container.register(CategoryRepository.self) { _ in
            CategoryRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(LoginRepository.self) { resolver in
            let tokenProvider = resolver.resolve(TokenProvider.self)!
            return LoginRepositoryImpl(tokenProvider: tokenProvider)
        }.inObjectScope(.container)
        
        container.register(MessageRepository.self) { _ in
            MessageRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(RoleRepository.self) { _ in
            RoleRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(StudiesRepository.self) { _ in
            StudiesRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(StudyProgramRepository.self) { _ in
            StudyProgramRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(TextChannelRepository.self) { _ in
            TextChannelRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(UserRepository.self) { _ in
            UserRepositoryImpl()
        }.inObjectScope(.container)
        
        // UseCases
        container.register(ChannelsForUserUsecase.self) { _ in
            ChannelsForUserUsecaseImpl()
        }.inObjectScope(.container)
        
        container.register(IsMyMessageUseCase.self) { _ in
            IsMyMessageUseCaseImpl()
        }.inObjectScope(.container)
        
        
        // ViewModels
    }
}
