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
        NavigationStack {
            VStack {
                List (chat.messages.indices, id: \.self){
                    i in
                    MessageView(chatType: chat.chatType,
                                currentMessage: chat.messages[i],
                                isLastMessageInColumn: isLastMessageInColumn(index: i)).listRowSeparator(.hidden).listRowBackground(Color.clear)
                    
                }.listStyle(.inset)
                    .scrollContentBackground(.hidden)
                    .background(Image("background"))
                HStack {
                    Image(systemName: "paperclip")
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(.roundedBorder)
                        .frame(minHeight: 30)
                    
                    Button(action: {}) {
                        Image(systemName: "arrow.up.circle.fill").resizable().frame(width: 30,height: 30)
                    }
                }.padding()
            }.navigationTitle(chat.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(.hidden, for: .tabBar)
        }
    }
    
    func isLastMessageInColumn(index:Int) -> Bool {
        if(index == (chat.messages.count - 1)){
            return true
        }
        return chat.messages[index].sender != chat.messages[index + 1].sender
    }
}

#Preview {
    ChatView(chat: Contact(unreadMessages: 1, chatType: .group,name: "Giorgio", messages: [Message(sender: "Giorgio", message: "Ciao!", date: Date()),Message(sender: myself, message: "Ciaoooo!", date: Date())]))
}
