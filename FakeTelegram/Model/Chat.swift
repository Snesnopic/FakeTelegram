//
//  Contact.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation
import SwiftUI

class Chat: Identifiable {
    var seenByOther: Bool
    var unreadMessages: Int
    var chatType: ChatTypeEnum
    var contact: Contact
    var messages: [Message]
    init(seenByOther: Bool = false, unreadMessages: Int = 0, chatType: ChatTypeEnum = .personal, contact: Contact = Contact(name: "Unkown contact"), messages: [Message] = []) {
        self.seenByOther = seenByOther
        self.unreadMessages = unreadMessages
        self.chatType = chatType
        self.contact = contact
        self.messages = messages
    }
    func getLastMessage() -> Message? {
        if messages.isEmpty {
            return nil
        } else {
            messages.sort {$0.date > $1.date}
            return messages[0]
        }
    }
    func getImage() -> Image {
        if contact.imageName != nil {
            return Image(contact.imageName!).resizable()
        }
        return Image(systemName: chatType.defaultImage)
    }
}
