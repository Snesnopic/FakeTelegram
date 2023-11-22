//
//  Message.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation
import SwiftData

@Model
class Message {
    var message: String
    var date: Date
    var sender: Contact?
    var chat:Chat?
    init(message: String, date: Date) {
        self.message = message
        self.date = date
    }
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
