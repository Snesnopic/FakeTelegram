//
//  ContentMessageView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI

struct ContentMessageView: View {
    var messageContent:String
    var isCurrentUser:Bool
    var body: some View {
        Text(messageContent)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color(UIColor.label))
            .background(isCurrentUser ? Color.blue : Color(UIColor.label).opacity(0.2))
            .cornerRadius(10)
    }
}

#Preview {
    ContentMessageView(messageContent: "Ciao!", isCurrentUser: false)
}
