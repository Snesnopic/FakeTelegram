//
//  Contact.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation

class Contact{
    var chatType:ChatTypeEnum
    var name:String
    var image:String?
    var sentMessages:[Message]
    var receivedMessages:[Message]
    init(chatType: ChatTypeEnum, name: String, image: String? = nil, sentMessages: [Message], receivedMessages: [Message]) {
        self.chatType = chatType
        self.name = name
        self.image = image
        self.sentMessages = sentMessages
        self.receivedMessages = receivedMessages
    }
}
