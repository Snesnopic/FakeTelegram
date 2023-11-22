//
//  ContentView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import SwiftUI
import SwiftData

struct ChatListView: View {
    @Query var chats: [Chat]
    @Query(filter: #Predicate<Contact> { !($0.isMyself) }) var contacts: [Contact]
    @State private var searchText = ""
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack {
            List(chats.filter { chat in
                return searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                chat.contact!.name.lowercased().contains(searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
            })
             { chat in
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
            .toolbarBackground(Color(UIColor.secondarySystemBackground), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .searchable(text: $searchText)
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear(perform: {
            ensureContactsHaveChats()
        })
        .badge(chats.reduce(0) { result, chat in
            result + chat.unreadMessages
        })
    }
    func ensureContactsHaveChats(){
        print(chats.count)
        if chats.isEmpty {
            for contact in contacts {
                let chat = Chat(seenByOther: false, unreadMessages: 0, chatType: .personal, contact: nil, messages: [], dateCreated: .now)
                contact.createdChats.append(chat)
                modelContext.insert(chat)
            }
        }
    }
}
   

//#Preview {
//    ChatListView()
//}
