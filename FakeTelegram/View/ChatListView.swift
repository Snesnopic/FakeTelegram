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
    Contact(unreadMessages: 4, chatType: .group, name: "Gruppo uscite sabato", messages: [Message(sender: myself,message: "Ciao", date: Date()),Message(sender: "Salvatore",message: "Alle 9 da Cibus", date: Date().addingTimeInterval(1))])]
struct ChatListView: View {
    
    
    @State private var selectedTab = 0
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            List(chats.filter{
                chat in
                return searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || chat.name.lowercased().contains(searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
            }.sorted(by: {
                chat1, chat2 in
                return chat1.getLastMessage().date > chat2.getLastMessage().date
            })){
                chat in
                HStack(alignment: .center){
                    Circle().stroke(.primary, lineWidth: 1)
                        .frame(width: 50, height: 50)
                        .overlay(Image(systemName: chat.image ?? chat.chatType.defaultImage).font(.system(size: 18)))
                    VStack(alignment: .leading){
                        Text(chat.name).bold()
                        if(chat.chatType != .personal){
                            Text(chat.getLastMessage().sender)
                        }
                        Text(chat.getLastMessage().message).opacity(0.4)
                    }
                    Spacer()
                    VStack (alignment: .trailing){
                        Text("\(chat.getLastMessage().getFormattedDate())")
                        Text("\(chat.unreadMessages)").padding(5).foregroundStyle(.background).background(Circle().foregroundStyle(chat.unreadMessages != 0 ? .blue :  Color(UIColor.systemBackground)))
                        
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

