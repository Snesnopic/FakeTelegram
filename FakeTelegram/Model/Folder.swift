//
//  Folder.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation

class Folder: Identifiable {
    var name: String
    var chats: [Chat]
    init(name: String, chats: [Chat]) {
        self.name = name
        self.chats = chats
    }
}
