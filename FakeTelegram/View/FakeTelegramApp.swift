//
//  FakeTelegramApp.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import SwiftUI

@main
struct FakeTelegramApp: App {
    var body: some Scene {
        WindowGroup{
            TabView{
                ChatListView().badge("!").tabItem { Label("Contacts",systemImage: "person.crop.circle") }.background(.gray)
                ChatListView().badge(chats.reduce(0) { result, chat in
                    result + chat.unreadMessages
                }).tabItem { Label("Chat",systemImage: "bubble.left.and.bubble.right.fill") }
                ChatListView().tabItem { Label("Settings",systemImage: "gear") }
            }
        }
        
    }
}
