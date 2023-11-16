//
//  FakeTelegramApp.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import SwiftUI

@main
struct FakeTelegramApp: App {
    @State private var selection: Int = 1
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                ChatListView().badge("!").tabItem { Label("Contacts", systemImage: "person.crop.circle") }
                    .background(.gray).tag(0)
                ChatListView().badge(chats.reduce(0) { result, chat in
                    result + chat.unreadMessages
                }).tabItem { Label("Chat", systemImage: "bubble.left.and.bubble.right.fill") }.tag(1)
                ChatListView().tabItem { Label("Settings", systemImage: "gear") }.tag(2)
            }
        }

    }
}
