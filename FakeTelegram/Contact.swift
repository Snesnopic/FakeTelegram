//
//  Contact.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation

class Contact: Identifiable{
    var chatType:ChatTypeEnum
    var name:String
    var image:String?
    var messages:[Message]
    init(chatType: ChatTypeEnum, name: String, image: String? = nil, messages: [Message]) {
        self.chatType = chatType
        self.name = name
        self.image = image
        self.messages = messages
    }
    func getLastMessage() -> Message {
        if(messages.isEmpty) {
            return Message(sender: "",message: "", date: Date())
        }
        else {
            messages.sort(){$0.date > $1.date}
            return messages[0]
        }
    }
}
