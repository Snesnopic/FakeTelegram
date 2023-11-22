//
//  Contact.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 16/11/23.
//

import Foundation
import SwiftData
@Model
class Contact: Equatable {
    @Attribute(.unique) var name: String
    var imageName: String
    var isMyself: Bool
    @Relationship(deleteRule: .cascade, inverse: \Chat.contact)
    var createdChats: [Chat] = []
    @Relationship(deleteRule: .cascade, inverse: \Message.sender)
    var createdMessages: [Message] = []
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name && lhs.imageName == rhs.imageName
    }
    init(name: String, imageName: String = "DEFAULTIMAGE", isMyself: Bool = false) {
        self.name = name
        self.imageName = imageName
        self.isMyself = isMyself
    }
    init(name: String) {
        self.name = name
        let index = Int.random(in: 0...45)
        if index < 24 {
            if index < 10 {
                self.imageName = "dog_000\(index)"
            } else {
                self.imageName = "dog_00\(index)"
            }
        } else {
            self.imageName = "DEFAULTIMAGE"
        }
        isMyself = false
    }
}
