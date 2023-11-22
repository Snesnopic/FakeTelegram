//
//  ContentMessageView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI

struct ContentMessageView: View {
    var sender: Contact
    var messageContent: String
    var body: some View {
        VStack(alignment: .leading) {
            if sender.isMyself {
                Text(sender.name).foregroundStyle(.blue)
            }
            Text(messageContent)
        }.padding(10)
            .foregroundColor(sender.isMyself ? Color.white : Color(UIColor.label))
            .background(sender.isMyself ? Color.blue : Color(UIColor.systemBackground))
    }
}
//
//#Preview {
//    ContentMessageView(messageContent: "Ciao!")
//}
