//
//  Folder.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation

class Folder: Identifiable {
    var name: String
    var chats: [Contact]
    init(name: String, chats: [Contact]) {
        self.name = name
        self.chats = chats
    }
}
