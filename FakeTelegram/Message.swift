//
//  Message.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation
class Message{
    var sender:String
    var message:String
    var date:Date
    init(sender: String, message: String, date: Date) {
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
