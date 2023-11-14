//
//  ChatTypeEnum.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 14/11/23.
//

import Foundation

enum ChatTypeEnum: String{
    case personal = "Personal"
    case channel = "Channel"
    case group = "Group"
    
    var defaultImage:String {
        switch self {
        case .personal:
            "person.fill"
        case .channel:
            "megaphone.fill"
        case .group:
            "person.3.fill"
        }
    }
}
