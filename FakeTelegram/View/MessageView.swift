//
//  MessageView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI
import SwiftData

struct MessageView: View {
    @Query(filter: #Predicate<Contact> { ($0.isMyself) }) var myself: [Contact]
    var chatType: ChatTypeEnum
    var currentMessage: Message
    var isLastMessageInColumn: Bool
    var imageName:String
    var body: some View {
        HStack(alignment: .bottom) {
            if currentMessage.sender!.isMyself {
                Spacer()
            }
            if !(currentMessage.sender!.isMyself) && chatType == .group {
                if imageName != "DEFAULTIMAGE" {
                    Image(imageName)
                        .frame(width: 30, height: 30, alignment: .center)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle").resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .clipShape(Circle()).background(Circle().frame(width: 30, height: 30).foregroundStyle(.background))
                }
            }

            ContentMessageView(sender: currentMessage.sender!, messageContent: currentMessage.message)
            .if(isLastMessageInColumn, transform: { cmv in
                cmv.clipShape(ChatBubbleShape(direction: currentMessage.sender!.isMyself ? .right : .left))
            }).if(!isLastMessageInColumn, transform: { cmv in
                cmv.clipShape(RoundedRectangle(cornerRadius: 25.0))
            })
            if !(currentMessage.sender!.isMyself) {
                Spacer()
            }
        }
    }
}

//#Preview {
//    // image:Image("dog_0001"),
//    MessageView(chatType: .group, currentMessage: Message(sender: Contact(name: "Raskol'Nikov"), message: "Ascanio is a better name",
//        date: Date()), isLastMessageInColumn: true)
//}
