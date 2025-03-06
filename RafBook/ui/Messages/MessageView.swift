import SwiftUI

var someUser = UserDTO(
    id: 100, firstName: "Neko", lastName: "Nekic", username: "NekoKo", email: "neko@ko.com", role: []
)
var parentMessafe: MessageDTO? = MessageDTO(
    id: 1111111, content: "Parent poruka", createdAt: "Sada", type: .text, mediaUrl: nil, sender: someUser, reactions: nil, deleted: false, edited: false
)

struct ChatMessageView: View {
    private let isMyMessage: Bool
    private let message: MessageDTO
    private let isMyMessageUseCase: IsMyMessageUseCase
    
    
    init(message: MessageDTO) {
        self.message = message
        self.isMyMessageUseCase = AppContainer.shared.container.resolve(IsMyMessageUseCase.self)!
        self.isMyMessage = self.isMyMessageUseCase.isMyMessage(message: self.message)
    }
    
    
    var body: some View {
        ReplyPreviewMessage(parentMessage: nil, isMyMessage: isMyMessage)
        MessageBubble(message: message, isMyMessage: isMyMessage)
        .contextMenu {
            if isMyMessage {
                Button("Edit") {
                    // Add edit action here.
                }
                Button("Delete", role: .destructive) {
                    // Add delete action here.
                }
            } else {
                Button("Reply") {
                    // Add reply action here.
                }
                Button("Report", role: .destructive) {
                    // Add report action here.
                }
            }
        }
        
    }
}
