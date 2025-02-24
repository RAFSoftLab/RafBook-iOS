//
//  ChannelsForUserUsecase.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 20.2.25..
//

protocol ChannelsForUserUsecase {
    func initialFetch() async throws -> [StudiesDTO]
}

final class ChannelsForUserUsecaseImpl: ChannelsForUserUsecase {
    private var loginRepository: LoginRepository
    private var studyProgramRepository: StudyProgramRepository
    private var studiesRepository: StudiesRepository
    private var categoryRepository: CategoryRepository
    private var textChannelRepository: TextChannelRepository
    private var messageRepository: MessageRepository
    
    init() {
        self.loginRepository = AppContainer.shared.container.resolve(LoginRepository.self)!
        self.studyProgramRepository = AppContainer.shared.container.resolve(StudyProgramRepository.self)!
        self.studiesRepository = AppContainer.shared.container.resolve(StudiesRepository.self)!
        self.categoryRepository = AppContainer.shared.container.resolve(CategoryRepository.self)!
        self.textChannelRepository = AppContainer.shared.container.resolve(TextChannelRepository.self)!
        self.messageRepository = AppContainer.shared.container.resolve(MessageRepository.self)!
    }
    
    
    func initialFetch() async throws -> [StudiesDTO] {
        
        let response = try await textChannelRepository.getAllChannelsForUser()
        studiesRepository.studies = response
        studiesRepository.studiesById = Dictionary<Int64, StudiesDTO>(
            uniqueKeysWithValues: response.map { ($0.id, $0) }
        )
        
        let studyPrograms: [StudyProgramDTO] = response.flatMap { $0.studyPrograms }
        studyProgramRepository.studyPrograms = studyPrograms
        studyProgramRepository.studyProgramsById = Dictionary<Int64, StudyProgramDTO>(
            uniqueKeysWithValues: studyPrograms.map { ($0.id, $0) }
        )
        
        let categories: [CategoryDTO] = studyPrograms.flatMap { $0.categories }
        categoryRepository.categories = categories
        categoryRepository.categoriesById = Dictionary<Int64, CategoryDTO>(
            uniqueKeysWithValues: categories.map { ($0.id, $0) }
        )
        
        let textChannels: [TextChannelDTO] = categories.flatMap { $0.textChannels }
        textChannelRepository.textChannels = textChannels
        textChannelRepository.textChannelsById = Dictionary<Int64, TextChannelDTO>(
            uniqueKeysWithValues: textChannels.map { ($0.id, $0) }
        )
        
        let messages: [MessageDTO] = textChannels.flatMap { $0.messageDTOList }
        messageRepository.messages = messages
        messageRepository.messagesById = Dictionary<Int64, MessageDTO>(
            uniqueKeysWithValues: messages.map { ($0.id, $0) }
        )
        
        return response
        
    }
}
