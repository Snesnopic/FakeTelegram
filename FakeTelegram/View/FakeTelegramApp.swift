//
//  FakeTelegramApp.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import SwiftUI
import SwiftData

@main
struct FakeTelegramApp: App {
    @State private var selection: Int = 1
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
                ContactsView().tabItem { Label("Contacts", systemImage: "person.crop.circle") }
                                    .background(.gray).tag(0)
                ChatListView().tabItem { Label("Chat", systemImage: "bubble.left.and.bubble.right.fill") }.tag(1)
                ChatListView().tabItem { Label("Settings", systemImage: "gear") }.tag(2)
            }
        }
        .modelContainer(for: [Chat.self,Contact.self,Message.self])
    }
}
