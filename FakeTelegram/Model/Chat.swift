//
//  Contact.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Chat: Identifiable {
    var seenByOther: Bool
    var unreadMessages: Int
    var chatType: ChatTypeEnum
    @Relationship var contact: Contact
    @Relationship var messages: [Message] = []
    var dateCreated: Date
    init(seenByOther: Bool = false, unreadMessages: Int = 0, chatType: ChatTypeEnum = .personal, contact: Contact, messages: [Message] = [],dateCreated: Date = Date()) {
        self.seenByOther = seenByOther
        self.unreadMessages = unreadMessages
        self.chatType = chatType
        self.contact = contact
        self.messages = messages
        self.dateCreated = dateCreated
    }
    func getLastMessage() -> Message {
        if messages.isEmpty {
            return Message(sender: Contact(name: "",imageName: "DEFAULTIMAGE"), message: "", date: dateCreated)
        } else {
            messages.sort()
            return messages[messages.endIndex - 1]
        }
    }
    func getImage() -> Image {
        if contact.imageName != "DEFAULTIMAGE" {
            return Image(contact.imageName).resizable()
        }
        return Image(systemName: chatType.defaultImage)
    }
}
