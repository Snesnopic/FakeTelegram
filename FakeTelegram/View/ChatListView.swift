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
    @Query(filter: #Predicate<Contact> { $0.isMyself }) var myself: [Contact]
    @State private var searchText = ""
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack {
            List(chats.filter { chat in
                return searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                chat.contact!.name.lowercased().contains(searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
            }.sorted(by: { chat1, chat2 in
                if !chat1.messages.isEmpty {
                    if !chat2.messages.isEmpty {
                        return chat1.messages.last!.date > chat2.messages.last!.date
                    }
                    return true
                }
                return false
            }))
             { chat in
                NavigationLink {
                    ChatView(chat: chat)
                } label: {
                    RectangularContactView(chat: chat)
                }
                .accessibility(label: Text(chat.unreadMessages != 0 ? "\(chat.name) \(chat.unreadMessages) unread messages." : "\(chat.name)"))
                .accessibilityRemoveTraits(.isSelected)
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .frame(height: 60)
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
                    Button(action: {
                        chat.isMuted.toggle()
                    }, label: {
                        VStack {
                            Image(systemName: chat.isMuted ? "speaker.wave.3.fill" : "speaker.slash.fill")
                            Text(chat.isMuted ? "Unmute" : "Mute")
                        }}).tint(.orange).accessibilityLabel(chat.isMuted ? Text("Unmute chat") : Text("Mute chat"))
                }
                .swipeActions(edge: .leading) {
                    Button(action: {
                        if chat.unreadMessages != 0 {
                            chat.unreadMessages = 0
                        }
                        else {
                            chat.unreadMessages = 1
                        }
                    }, label: {
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
                    }).accessibilityLabel(Text("New story"))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "square.and.pencil")
                    }).accessibilityLabel(Text("New chat"))
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
        }).onAppear {
            ensureContactsExists()
            ensureContactsHaveChats()
            ensureChatsHaveSomeMessages()
        }
    }
    func ensureChatsHaveSomeMessages(){
        for chat in chats {
            if chat.name == "Gianluca" && chat.messages.isEmpty{
                let newMessage = Message(message: "Hi Giuseppe, how are you?", date: .now)
                chat.contact!.createdMessages.append(newMessage)
                chat.messages.append(newMessage)
                modelContext.insert(newMessage)
                let newMessage2 = Message(message: "Gianluca, you still have to give me 50 euros...", date: .now)
                myself[0].createdMessages.append(newMessage2)
                chat.messages.append(newMessage2)
                modelContext.insert(newMessage2)
                do {
                    try modelContext.save()
                }
                catch {
                    fatalError("\(error)")
                }
            }
            if chat.chatType == .group && chat.messages.isEmpty {
                let newMessage = Message(message: "Guys, I love this name too much...", date: .now)
                contacts[Int.random(in: 0...contacts.count - 1)].createdMessages.append(newMessage)
                chat.messages.append(newMessage)
                modelContext.insert(newMessage)
                let newMessage2 = Message(message: "Seriously, it's the best!", date: .now)
                contacts[Int.random(in: 0...contacts.count - 1)].createdMessages.append(newMessage2)
                chat.messages.append(newMessage2)
                modelContext.insert(newMessage2)
                let newMessage3 = Message(message: "I will name my children Ascanio. I will, I swear.", date: .now)
                myself[0].createdMessages.append(newMessage3)
                chat.messages.append(newMessage3)
                do {
                    try modelContext.save()
                }
                catch {
                    fatalError("\(error)")
                }
            }
        }
    }
    func ensureContactsHaveChats(){
        if chats.count - 1 == 0 {
            for contact in contacts {
                let chat = Chat(name: contact.name, seenByOther: false, unreadMessages: 0, chatType: .personal, contact: nil, messages: [], dateCreated: .now)
                contact.createdChats.append(chat)
                modelContext.insert(chat)
            }
        }
    }
    func ensureContactsExists() {
        if contacts.isEmpty {
            do{
                let marcoContact = Contact(name: "Marco")
                modelContext.insert(marcoContact)
                let ascanioContact = Contact(name: "Ascanio")
                modelContext.insert(ascanioContact)
                let matteoContact = Contact(name: "Matteo")
                modelContext.insert(matteoContact)
                let elisaContact = Contact(name: "Elisa")
                modelContext.insert(elisaContact)
                let gianlucaContact = Contact(name: "Gianluca")
                modelContext.insert(gianlucaContact)
                let salvatoreContact = Contact(name: "Salvatore")
                modelContext.insert(salvatoreContact)
                let ascanioGroup = Chat(name: "Ascanio name lovers", seenByOther: true, unreadMessages: 3, chatType: .group, contact: nil, messages: [], dateCreated: .now)
               
                let myself = Contact(name: "me",isMyself: true)
                modelContext.insert(myself)
                myself.createdChats.append(ascanioGroup)
                modelContext.insert(ascanioGroup)
                try modelContext.save()
            }
            catch{
                fatalError("\(error)")
            }
        }
    }
}
   

//#Preview {
//    ChatListView()
//}
