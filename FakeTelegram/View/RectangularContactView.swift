//
//  RectangularContactView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 14/11/23.
//

import SwiftUI

struct RectangularContactView: View {
    var chat: Chat
    var body: some View {
        HStack(alignment: .center) {
            chat.getImage().frame(width: 60, height: 60).clipShape(Circle())
            VStack(alignment: .leading) {
                Text(chat.contact.name).bold()
                if chat.chatType != .personal {
                    Text(chat.getLastMessage().sender.name)
                }
                Text(chat.getLastMessage().message).opacity(0.4)
            }
            Spacer(minLength: 3)
            VStack(alignment: .trailing) {
                HStack {
                    if chat.chatType != .channel && chat.messages.first?.sender == myself {
                        ZStack(alignment: .trailing) {
                            Image(systemName: "checkmark").foregroundStyle(.blue)
                            if chat.seenByOther {
                                Image(systemName: "checkmark").foregroundStyle(.blue).padding(.trailing, 8)
                            }
                        }
                    }
                    Text("\(chat.getLastMessage().getFormattedDate())").opacity(0.5)
                }
                Text("\(chat.unreadMessages)").padding(5).foregroundStyle(
                    chat.unreadMessages != 0 ? Color(UIColor.systemBackground) :  Color.clear).background(Circle()
                    .foregroundStyle(chat.unreadMessages != 0 ? .blue :  Color.clear))
            }
        }
    }
}

#Preview {
    let message = Message(sender: Contact(name: "Giangiorgio"), message: "Ciao!", date: Date())
    let chat = Chat(seenByOther: false, unreadMessages: 2, chatType: .personal, contact: Contact(name: "Giangiorgio"), messages: [message])
    return RectangularContactView(chat: chat)
}
