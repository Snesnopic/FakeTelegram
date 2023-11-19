//
//  Message.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation
class Message: Hashable, Comparable {
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.sender == rhs.sender && lhs.message == rhs.message && lhs.date == rhs.date
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(sender.name)
        hasher.combine(message)
        hasher.combine(date)
    }

    var sender: Contact
    var message: String
    var date: Date
    init(sender: Contact, message: String, date: Date) {
        self.sender = sender
        self.message = message
        self.date = date
    }
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
let myself: Contact = Contact(name: "me")
