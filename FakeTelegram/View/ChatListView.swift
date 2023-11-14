//
//  ContentView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import SwiftUI
var chats:[Contact] = [
    Contact(unreadMessages: 2, chatType: .personal, name: "Gianluca", messages: [Message(sender: myself,message: "Ciao", date: Date())]),
    Contact(unreadMessages: 0, chatType: .channel, name: "Meme channel", messages: [Message(sender: "Claudio",message: "Mario Doccia", date: Date())]),
    Contact(unreadMessages: 4, chatType: .group, name: "Gruppo uscite sabato", messages: [Message(sender: myself,message: "Ciao, come stai?", date: Date()),Message(sender: "Salvatore",message: "Alle 9 da Cibus", date: Date().addingTimeInterval(1))])]
struct ChatListView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            List(chats.filter{
                chat in
                return searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                chat.name
                    .lowercased()
                    .contains(searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
            }.sorted(by: {
                chat1, chat2 in
                return chat1.getLastMessage().date > chat2.getLastMessage().date
            })){
                chat in
                RectangularContactView(chat: chat)
                .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(.background)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive, action: {}, label: {
                        VStack{
                            Image(systemName: "trash.fill")
                            Text("Delete").font(.caption)
                        }})
                    Button(action: {}, label: {
                        VStack{
                            Image(systemName: "speaker.slash.fill")
                            Text("Mute")
                        }})
                }
                .swipeActions(edge: .leading){
                    Button(action: {}, label: {
                        VStack{
                            Image(systemName: "message.badge.filled.fill")
                            Text("Unread")
                        }}).tint(.blue)
                    Button(action: {}, label: {
                        VStack{
                            Image(systemName: "pin.fill")
                            Text("Pin")
                        }}).tint(.green)
                }
            }.listStyle(.plain)
                .searchable(text: $searchText)
                .navigationTitle("Chats")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading)
                    {
                        Button(action: {}, label: {
                            Text("Edit")
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing)
                    {
                        Button(action: {}, label: {
                            Image(systemName: "plus.square.dashed")
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing)
                    {
                        Button(action: {}, label: {
                            Image(systemName: "square.and.pencil")
                        })
                    }
                }.background(.foreground.opacity(0.03))
        }
    }
}

#Preview {
    ChatListView()
}

