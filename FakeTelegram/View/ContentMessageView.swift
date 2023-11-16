//
//  ContentMessageView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI

struct ContentMessageView: View {
    var sender: String?
    var messageContent: String
    var isCurrentUser: Bool
    var body: some View {
        VStack(alignment: .leading) {
            if sender != nil && sender != myself {
                Text(sender!)
            }
            Text(messageContent)
        }.padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color(UIColor.label))
            .background(isCurrentUser ? Color.blue : Color(UIColor.systemBackground))
    }
}

#Preview {
    ContentMessageView(messageContent: "Ciao!", isCurrentUser: false)
}
