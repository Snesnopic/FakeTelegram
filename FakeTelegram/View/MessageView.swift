//
//  MessageView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI

struct MessageView: View {
    var image: Image?
    var chatType: ChatTypeEnum
    var currentMessage: Message
    var isLastMessageInColumn: Bool
    var body: some View {
        HStack(alignment: .bottom) {
            if currentMessage.sender == myself {
                Spacer()
            }
            if currentMessage.sender != myself && chatType == .group {
                if image != nil {
                    image!
                        .frame(width: 30, height: 30, alignment: .center)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle").resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .clipShape(Circle())
                }
            }

            ContentMessageView(sender: chatType == .group ? currentMessage.sender : nil, messageContent: currentMessage.message,
                               isCurrentUser: currentMessage.sender == myself).if(isLastMessageInColumn, transform: { cmv in
                cmv.clipShape(ChatBubbleShape(direction: currentMessage.sender == myself ? .right : .left))
            }).if(!isLastMessageInColumn, transform: { cmv in
                cmv.clipShape(RoundedRectangle(cornerRadius: 25.0))
            })

            if currentMessage.sender != myself {
                Spacer()
            }

        }
    }
}

#Preview {
    MessageView(// image:Image("dog_0001"),
        chatType: .group, currentMessage: Message(sender: myself, message: "Ascanio is a better name", date: Date()), isLastMessageInColumn: true)
}
