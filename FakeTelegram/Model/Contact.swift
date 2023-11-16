//
//  Contact.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation
import SwiftUI

class Contact: Identifiable {
    var seenByOther: Bool = false
    var unreadMessages: Int
    var chatType: ChatTypeEnum
    var name: String
    var image: Image
    var messages: [Message]
    init(unreadMessages: Int, chatType: ChatTypeEnum, name: String, messages: [Message]) {
        self.unreadMessages = unreadMessages
        self.chatType = chatType
        self.name = name
        let index = Int.random(in: 0...45)
        if index < 24 {
            if index < 10 {
                self.image = Image("dog_000\(index)").resizable()
            } else {
                self.image =  Image("dog_00\(index)").resizable()
            }
        } else {
            self.image = Image(systemName: chatType.defaultImage)
        }
        self.messages = messages
    }
    init(unreadMessages: Int, chatType: ChatTypeEnum, name: String, messages: [Message], seenByOther: Bool) {
        self.unreadMessages = unreadMessages
        self.chatType = chatType
        self.name = name
        let index = Int.random(in: 0...45)
        if index < 24 {
            if index < 10 {
                self.image = Image("dog_000\(index)").resizable()
            } else {
                self.image =  Image("dog_00\(index)").resizable()
            }
        } else {
            self.image = Image(systemName: chatType.defaultImage)
        }
        self.messages = messages
        self.seenByOther = seenByOther
    }
    func getLastMessage() -> Message {
        if messages.isEmpty {
            return Message(sender: "", message: "", date: Date())
        } else {
            messages.sort {$0.date > $1.date}
            return messages[0]
        }
    }
}
