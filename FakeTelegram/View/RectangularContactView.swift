//
//  RectangularContactView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 14/11/23.
//

import SwiftUI
import SwiftData

struct RectangularContactView: View {
    
    @Query(filter: #Predicate<Contact> { ($0.isMyself) }) var myself: [Contact]
    var chat: Chat
    var body: some View {
        HStack(alignment: .center) {
            chat.getImage().frame(width: 60, height: 60).clipShape(Circle())
            VStack(alignment: .leading) {
                Text(chat.contact!.name).bold()
                if chat.chatType != .personal {
                    if !chat.messages.isEmpty {
                        Text(chat.messages.last!.sender!.name)
                        Text(chat.messages.last!.message)
                    }
                }
                if !chat.messages.isEmpty {
                    Text(chat.messages.last!.message).opacity(0.4)
                }
            }
            Spacer(minLength: 3)
            VStack(alignment: .trailing) {
                HStack {
                    if chat.chatType != .channel && !chat.messages.isEmpty && chat.messages.last!.sender!.isMyself {
                        ZStack(alignment: .trailing) {
                            Image(systemName: "checkmark").foregroundStyle(.blue)
                            if chat.seenByOther {
                                Image(systemName: "checkmark").foregroundStyle(.blue).padding(.trailing, 8)
                            }
                        }
                    }
                    if !chat.messages.isEmpty {
                        Text("\(chat.messages.last!.getFormattedDate())").opacity(0.5)
                    }
                }
                Text("\(chat.unreadMessages)").padding(5).foregroundStyle(
                    chat.unreadMessages != 0 ? Color(UIColor.systemBackground) :  Color.clear).background(Circle()
                    .foregroundStyle(chat.unreadMessages != 0 ? .blue :  Color.clear))
            }
        }
    }
}

//#Preview {
//    let message = Message(sender: Contact(name: "Giangiorgio"), message: "Ciao!", date: Date())
//    let chat = Chat(seenByOther: false, unreadMessages: 2, chatType: .personal, contact: Contact(name: "Giangiorgio"), messages: [message])
//    return RectangularContactView(chat: chat)
//}
