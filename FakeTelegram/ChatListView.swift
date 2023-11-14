//
//  ContentView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import SwiftUI

struct ChatListView: View {
    var folders:[Folder] = [Folder(name: "Work colleagues", chats: [Contact(chatType: .personal, name: "Gianluca", sentMessages: [], receivedMessages: [])]),Folder(name: "Meme channels", chats: [Contact(chatType: .channel,name: "Memes", sentMessages: [], receivedMessages: [])]),Folder(name: "Database", chats: [Contact(chatType: .group,name: "Peeps from Secondigliano", sentMessages: [], receivedMessages: [])]),]
    init(){
        
    }
    @State private var selectedTab = 0
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            VStack {
                VStack{
                    Color.clear.frame(height: 90)
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    } .padding(.vertical, 10)
                        .padding(.horizontal, 130)
                        .background(Color.secondary.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                }.background(.gray.opacity(0.2)).ignoresSafeArea()
                
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    VStack {
                        Text("Chat").bold()
                    }
                }
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
            }
        }
    }
}

#Preview {
    ChatListView()
}

