//
//  ContentView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import SwiftUI

struct ChatListView: View {
    var chats:[Contact] = [
        Contact(chatType: .personal, name: "Gianluca", messages: [Message(sender: myself,message: "Ciao", date: Date())]),
        Contact(chatType: .channel, name: "Meme channel", messages: [Message(sender: "Claudio",message: "Mario Doccia", date: Date())]),
        Contact(chatType: .group, name: "Gruppo uscite sabato", messages: [Message(sender: myself,message: "Ciao", date: Date()),Message(sender: "Salvatore",message: "Alle 9 da Cibus", date: Date().addingTimeInterval(1))])]
    
    @State private var selectedTab = 0
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            List(chats.sorted(by: {
                chat1, chat2 in
                return chat1.getLastMessage().date > chat2.getLastMessage().date
            })){
                chat in
                HStack(alignment: .top){
                    Circle().stroke(.primary, lineWidth: 1)
                        .frame(width: 70, height: 70)
                        .overlay(Image(systemName: chat.image ?? chat.chatType.defaultImage).font(.system(size: 32)))
                    VStack(alignment: .leading){
                        Text(chat.name).bold()
                        Text(chat.getLastMessage().message).opacity(0.8)
                    }
                    Spacer()
                    VStack {
                        Text("\(chat.getLastMessage().getFormattedDate())")
                    }
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(.background)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive, action: {}, label: {
                        VStack{
                            Image(systemName: "trash.fill")
                            Text("Delete")
                        }})
                    Button(action: {}, label: {
                        VStack{
                            Image(systemName: "speaker.slash.fill")
                            Text("Mute")
                        }}).tint(.orange)
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

