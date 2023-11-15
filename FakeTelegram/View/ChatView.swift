//
//  ChatView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI

struct ChatView: View {
    var chat:Contact
    @State private var typingMessage:String = ""
    var body: some View {
        VStack {
            List {
                ForEach(chat.messages, id: \.self) { msg in
                    MessageView(chatType: chat.chatType, currentMessage: msg, isLastMessageInColumn: false)
                }
            }
            HStack {
                TextField("Message...", text: $typingMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                
                Button(action: {}) {
                    Text("Send")
                }
            }.padding()
        }
    }
}

#Preview {
    ChatView(chat: Contact(unreadMessages: 1, chatType: .personal,name: "Giorgio", messages: [Message(sender: "Giorgio", message: "Ciao!", date: Date()),Message(sender: myself, message: "Ciaoooo!", date: Date())]))
}
