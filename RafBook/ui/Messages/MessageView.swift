import SwiftUI

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
        if isMyMessage {
            HStack {
                Spacer(minLength: 40)
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(8)
                    Text(message.createdAt)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal)
        } else {
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                    .padding(.top, 2)
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.sender.username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Text(message.content)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                    Text(message.createdAt)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.vertical, 6)
            .padding(.horizontal)
        }
    }
}
