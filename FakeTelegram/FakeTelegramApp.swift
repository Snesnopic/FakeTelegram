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
                ChatListView().badge("!").tabItem { Label("Contacts",systemImage: "person.circle.fill") }
                ChatListView().badge(2).tabItem { Label("Chat",systemImage: "bubble.left.and.bubble.right.fill") }
                ChatListView().tabItem { Label("Settings",systemImage: "gear") }
            }
        }
        
    }
}
