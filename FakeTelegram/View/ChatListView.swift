//
//  ContentView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import SwiftUI

struct ChatListView: View {

    @State private var chats: [Chat] = [
        Chat(seenByOther: true, unreadMessages: 0, chatType: .personal, contact: Contact(name: "Gianluca"), messages: [Message(sender: Contact(name: "Gianluca"), message: "Ciao", date: Date())]),

        Chat(seenByOther: false, unreadMessages: 3, chatType: .channel, contact:
                Contact(name: "Meme channel"), messages: [Message(sender:
                Contact(name: "Meme channel"), message: "Wassup", date: Date())]),

        Chat(seenByOther: false, unreadMessages: 3, chatType: .group, contact:
                Contact(name: "Uscite sabato"), messages: [Message(sender: myself, message: "Ciao, come stai?", date: Date()), Message(sender:
                Contact(name: "Salvatore"), message: "Alle 9 da Cibus", date: Date())])]
    
    init() {
        chats.sort { chat1, chat2 in
            return chat1.getLastMessage() > chat2.getLastMessage()
        }
    }

    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            List(chats.filter { chat in
                return searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                chat.contact.name.lowercased().contains(searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
            }.sorted(by: { chat1, chat2 in
                return chat1.getLastMessage() > chat2.getLastMessage()
            })) { chat in
                NavigationLink {
                    ChatView(chat: chat)
                } label: {
                    RectangularContactView(chat: chat)
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .frame(height: 70)
                .swipeActions(edge: .trailing) {
                    if chat.chatType != .personal {
                        Button(action: {}, label: {
                            VStack {
                                Image(systemName: "archivebox.fill")
                                Text("Archive")
                            }
                        })
                    }
                    Button(role: .destructive, action: {}, label: {
                        VStack {
                            Image(systemName: "trash.fill")
                            Text("Delete")
                        }})
                    Button(action: {}, label: {
                        VStack {
                            Image(systemName: "speaker.slash.fill")
                            Text("Mute").font(.footnote)
                        }}).tint(.orange)
                }
                .swipeActions(edge: .leading) {
                    Button(action: {}, label: {
                        VStack {
                            Image(systemName: chat.unreadMessages != 0 ? "message.fill" : "message.badge.filled.fill")
                            Text(chat.unreadMessages != 0 ? "Read" : "Unread")
                        }}).tint(chat.unreadMessages != 0 ? .gray : .blue)
                    Button(action: {}, label: {
                        VStack {
                            Image(systemName: "pin.fill")
                            Text("Pin")
                        }}).tint(.green)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "plus.square.dashed")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "square.and.pencil")
                    })
                }
            }
            .listStyle(.plain)
            .toolbarBackground(Color(UIColor.systemBackground).opacity(0.03), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .searchable(text: $searchText)
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
        }.badge(chats.reduce(0) { result, chat in
            result + chat.unreadMessages
        })
    }
}

#Preview {
    ChatListView()
}
