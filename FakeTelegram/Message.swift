//
//  Message.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 13/11/23.
//

import Foundation
class Message{
    var message:String
    var date:Date
    init(message: String, date: Date) {
        self.message = message
        self.date = date
    }
}
