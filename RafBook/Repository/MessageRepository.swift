//
//  MessageRepository.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 17.2.25..
//

protocol MessageRepository{
    var messages: [MessageDTO] { get set }
    var messagesById: [Int64: MessageDTO] { get set }
    func sendMessage(_ message: NewMessageDTO) async throws -> MessageDTO
    func editMessage(_ message: MessageDTO, newContent: String) async throws -> MessageDTO
    func deleteMessage(_ message: MessageDTO) async throws
}

class MessageRepositoryImpl: MessageRepository{
    var messages: [MessageDTO] = []
    var messagesById: [Int64 : MessageDTO] = [:]
    
    private let networkService: NetworkService
    
    init() {
        self.networkService = AppContainer.shared.container.resolve(NetworkService.self)!
    }
    
    func sendMessage(_ message: NewMessageDTO) async throws -> MessageDTO{
        let urlPath = "/messages"
        let respondMessage: MessageDTO = try await networkService.post(urlPath: urlPath, body: message)
        messages.append(respondMessage)
        messagesById[respondMessage.id] = respondMessage
        return respondMessage
    }
    
    func deleteMessage(_ message: MessageDTO) async throws {
        let urlPath = "/messages/\(message.id)"
        let _: EmptyResponse = try await networkService.delete(urlPath: urlPath, parameters: nil)
        messagesById.removeValue(forKey: message.id)
        messages.removeAll(where: {$0.id == message.id})
    }
    
    func editMessage(_ message: MessageDTO, newContent: String) async throws -> MessageDTO {
        let updatedMessage = message.updated(content: newContent)
        let urlPath = "/messages/\(message.id)"
        let response: MessageDTO = try await networkService.put(urlPath: urlPath, body: updatedMessage)
        messagesById[message.id] = response
        messages.removeAll(where: {$0.id == message.id})
        messages.append(response)
        return response
    }
    
}

extension MessageDTO {
    func updated(content: String, edited: Bool = true) -> MessageDTO {
        MessageDTO(
            id: self.id,
            content: content,
            createdAt: self.createdAt,
            type: self.type,
            mediaUrl: self.mediaUrl,
            sender: self.sender,
            reactions: self.reactions,
            deleted: self.deleted,
            edited: edited
        )
    }
}

