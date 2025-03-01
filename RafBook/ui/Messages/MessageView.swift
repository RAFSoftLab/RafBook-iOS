import SwiftUI

struct ChatMessageView: View {
    private let isMyMessage: Bool
    private let message: MessageDTO
    private let isMyMessageUseCase: IsMyMessageUseCase
    
    init(message: MessageDTO){
        self.message = message
        self.isMyMessageUseCase = AppContainer.shared.container.resolve(IsMyMessageUseCase.self)!
        self.isMyMessage = self.isMyMessageUseCase.isMyMessage(message: self.message)
    }

    var body: some View {
        HStack(alignment: .top) {
            if !isMyMessage {
                // Avatar for incoming messages
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                    .padding(.top, 2)
            } else {
                Spacer(minLength: 40)  // reserve space for symmetry if desired
            }
            
            VStack(alignment: isMyMessage ? .trailing : .leading, spacing: 4) {
                if !isMyMessage {
                    Text(message.sender.username)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                Text(message.content)
                    .font(.body)
                    .foregroundColor(isMyMessage ? .white : .primary)
                    .padding(10)
                    .background(isMyMessage ? Color.blue : Color(.systemGray5))
                    .cornerRadius(8)
                Text(message.createdAt)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            if isMyMessage {
                Spacer()
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal)
    }
}

