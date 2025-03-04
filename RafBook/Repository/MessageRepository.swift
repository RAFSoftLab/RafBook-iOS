//
//  MessageRepository.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

protocol MessageRepository{
    var messages: [MessageDTO] { get set }
    var messagesById: [Int64: MessageDTO] { get set }
    func sendTextMessage(_ message: NewMessageDTO) async throws -> MessageDTO
}

class MessageRepositoryImpl: MessageRepository{
    var messages: [MessageDTO] = []
    var messagesById: [Int64 : MessageDTO] = [:]
    
    private let networkService: NetworkService
    
    init() {
        self.networkService = AppContainer.shared.container.resolve(NetworkService.self)!
    }
    
    func sendTextMessage(_ message: NewMessageDTO) async throws -> MessageDTO{
        let respondMessage: MessageDTO = try await networkService.post(urlPath: "messages", body: message)
        messages.append(respondMessage)
        messagesById[respondMessage.id] = respondMessage
        return respondMessage
    }
    
    
}
