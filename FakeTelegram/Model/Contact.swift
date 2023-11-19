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
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name && lhs.imageName == rhs.imageName
    }
    init(name: String, imageName: String = "DEFAULTIMAGE") {
        self.name = name
        self.imageName = imageName
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
    }
}

let myself: Contact = Contact(name: "me")
