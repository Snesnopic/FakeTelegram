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
    var name: String
    var seenByOther: Bool = false
    var unreadMessages: Int = 0
    var chatType: ChatTypeEnum
    var contact: Contact? = nil
    @Relationship(deleteRule: .cascade,inverse: \Message.chat)
    var messages: [Message] = []
    var dateCreated: Date = Date.now
    var isMuted: Bool = false
    
    init(name: String, seenByOther: Bool, unreadMessages: Int, chatType: ChatTypeEnum, contact: Contact?, messages: [Message], dateCreated: Date) {
        self.name = name
        self.seenByOther = seenByOther
        self.unreadMessages = unreadMessages
        self.chatType = chatType
        self.contact = contact
        self.messages = messages
        self.dateCreated = dateCreated
    }
    
    func getImage() -> Image {
        if contact!.imageName != "DEFAULTIMAGE" {
            return Image(contact!.imageName).resizable()
        }
        return Image(systemName: chatType.defaultImage)
    }
}
