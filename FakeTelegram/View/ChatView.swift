//
//  ChatView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    @Query(filter: #Predicate<Contact> { $0.isMyself }) var myself: [Contact]
    @Bindable var chat: Chat
    @State private var typingMessage: String = ""
    @Environment(\.modelContext) var modelContext
    let dateFormatter = DateFormatter()
    init(chat: Chat) {
        dateFormatter.dateFormat = "MMMM d"
        self.chat = chat
    }
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(chat.messages) { message in
                        if chat.messages.first! == message {
                            HStack (alignment: .center) {
                                Spacer()
                                Text(dateFormatter.string(from: message.date)).foregroundStyle(.background).padding(.horizontal, 10).background(RoundedRectangle(cornerRadius: 25)).foregroundStyle(.gray.opacity(0.3))
                                Spacer()
                            }.listRowBackground(Color.clear)
                                .accessibilityLabel(Text("\(dateFormatter.string(from: message.date))"))
                        }
                        MessageView(chatType: chat.chatType,
                                    currentMessage: message,
                                    isLastMessageInColumn: isLastMessageInColumn(message: message), imageName: message.sender!.imageName)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(Text("Message by \(message.sender!.name): \(message.message)"))

                    }
                }.listStyle(.inset)
                    .scrollContentBackground(.hidden)

                HStack {
                    Button(action: {}) {
                        Image(systemName: "paperclip")
                    }.accessibilityLabel(Text("Attach photo or video"))
                   
                    TextField("Message...", text: $typingMessage)
                        .textFieldStyle(.roundedBorder)
                        .frame(minHeight: 30)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(Text("Message text field"))
                    Button(action: {
                        let newMessage = Message(message: typingMessage, date: .now)
                        myself[0].createdMessages.append(newMessage)
                        chat.messages.append(newMessage)
                        modelContext.insert(newMessage)
                        typingMessage = ""
                        do{
                            try modelContext.save()
                        }
                        catch {
                            print("\(error)")
                        }
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }.accessibilityLabel(Text("Send message"))
                }.padding().background(Color(UIColor.systemBackground).opacity(0.8))
            }.background(Image("background").accessibilityHidden(true))
                .navigationTitle(chat.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(.hidden, for: .tabBar)
                .toolbarBackground(Color(UIColor.systemBackground).opacity(0.03), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        chat.getImage().frame(width: 30, height: 30).clipShape(Circle()).font(.system(size: 12))
                            .accessibilityHidden(true)
                    }
                }
        }
    }
    func isLastMessageInColumn(message: Message) -> Bool {
        let index = chat.messages.firstIndex(of: message)!
        if index == (chat.messages.count - 1) {
            return true
        }
        return chat.messages[index].sender != chat.messages[index + 1].sender
    }
}
//
//#Preview {
//    let messages = [Message(sender: Contact(name: "Gianluca"), message: "Questa è una risposta",
//                            date: Date()), Message(sender: myself, message: "Ciao!", date: Date())]
//    return ChatView(chat: Chat(seenByOther: true, unreadMessages: 2, chatType: .group, contact: Contact(name: "Gianluca"), messages: messages))
//}
