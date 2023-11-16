//
//  ChatView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI

struct ChatView: View {
    @State var chat: Chat
    @State private var typingMessage: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(chat.messages.sorted(by: { chat1, chat2 in
                        return chat1.date > chat2.date
                    }).indices, id: \.self) { index in
                        MessageView(chatType: chat.chatType,
                                    currentMessage: chat.messages[index],
                                    isLastMessageInColumn: isLastMessageInColumn(index:
                                    index))
                        .listRowInsets(EdgeInsets(.zero))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }.listStyle(.inset)
                    .scrollContentBackground(.hidden)

                HStack {
                    Image(systemName: "paperclip")
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(.roundedBorder)
                        .frame(minHeight: 30)
                    Button(action: {
                        if !typingMessage.isEmpty {
                            chat.messages.append(Message(sender: myself, message: typingMessage, date: Date()))
                            typingMessage = ""
                        }
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }.padding().background(Color(UIColor.systemBackground).opacity(0.8))
            }.background(Image("background")).navigationTitle(chat.contact.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(.hidden, for: .tabBar)
                .toolbarBackground(Color(UIColor.systemBackground).opacity(0.03), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        chat.getImage().frame(width: 30, height: 30).clipShape(Circle()).font(.system(size: 12))
                    }
                }
        }
    }
    func isLastMessageInColumn(index: Int) -> Bool {
        if index == (chat.messages.count - 1) {
            return true
        }
        return chat.messages[index].sender != chat.messages[index + 1].sender
    }
}

#Preview {
    let messages = [Message(sender: Contact(name: "Gianluca"), message: "Questa è una risposta",
    date: Date().addingTimeInterval(4)), Message(sender: myself, message: "Ciao!", date: Date().addingTimeInterval(2))]
    return ChatView(chat: Chat(seenByOther: true, unreadMessages: 2, chatType: .group, contact: Contact(name: "Gianluca"), messages: messages))
}
