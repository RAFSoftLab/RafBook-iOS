//
//  SendNewMessageUseCase.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 3.3.25..
//

protocol SendNewMessageUseCase {
    func sendTextMessage(to: TextChannelDTO, content: String) async throws -> MessageDTO
}

final class SendNewMessageUseCaseImpl: SendNewMessageUseCase {
    private var messageRepository: MessageRepository
    private var loginRepository: LoginRepository
    
    init() {
        self.messageRepository = AppContainer.shared.container.resolve(MessageRepository.self)!
        self.loginRepository = AppContainer.shared.container.resolve(LoginRepository.self)!
    }
    
    func sendTextMessage(to: TextChannelDTO, content: String) async throws -> MessageDTO {
        let newMessage = NewMessageDTO(
            content: content, type: .text, mediaUrl: nil, parentMessage: nil, textChannel: to.id
        )
        return try await messageRepository.sendTextMessage(newMessage)
    }
    

}

//struct NewMessageDTO: Codable {
//    let content: String
//    let type: MessageType
//    let mediaUrl: [String]?
//    let parentMessage: Int64?
//    let textChannel: Int64
//}
