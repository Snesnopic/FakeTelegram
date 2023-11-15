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
            List (chat.messages.indices, id: \.self){
                i in
                MessageView(chatType: chat.chatType,
                            currentMessage: chat.messages[i],
                            isLastMessageInColumn: isLastMessageInColumn(index: i)).listRowSeparator(.hidden)
                
            }.listStyle(.inset)
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
    func isLastMessageInColumn(index:Int) -> Bool {
        if(index == (chat.messages.count - 1)){
            return true
        }
        if(chat.messages[index].sender != chat.messages[index + 1].sender) {
            return false
            
        }
        return true
    }
}

#Preview {
    ChatView(chat: Contact(unreadMessages: 1, chatType: .group,name: "Giorgio", messages: [Message(sender: "Giorgio", message: "Ciao!", date: Date()),Message(sender: myself, message: "Ciaoooo!", date: Date())]))
}
