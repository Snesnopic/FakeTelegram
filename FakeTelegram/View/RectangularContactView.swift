//
//  RectangularContactView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 14/11/23.
//

import SwiftUI

struct RectangularContactView: View {
    var chat:Contact
    var body: some View {
        HStack(alignment: .center){
            chat.image.frame(width: 60, height: 60).clipShape(Circle())
            VStack(alignment: .leading){
                Text(chat.name).bold()
                if(chat.chatType != .personal){
                    Text(chat.getLastMessage().sender)
                }
                Text(chat.getLastMessage().message).opacity(0.4)
            }
            Spacer(minLength: 3)
            VStack (alignment: .trailing){
                HStack {
                    if chat.chatType != .channel && chat.messages.first?.sender == myself{
                        ZStack (alignment: .trailing){
                            Image(systemName: "checkmark").foregroundStyle(.blue)
                            if(chat.seenByOther){
                                Image(systemName: "checkmark").foregroundStyle(.blue).padding(.trailing, 8)
                            }
                        }
                    }
                    Text("\(chat.getLastMessage().getFormattedDate())").opacity(0.5)
                }
                Text("\(chat.unreadMessages)").padding(5).foregroundStyle(.background).background(Circle().foregroundStyle(chat.unreadMessages != 0 ? .blue :  Color(UIColor.systemBackground)))
            }
        }
    }
}

#Preview {
    RectangularContactView(chat: Contact(unreadMessages: 2, chatType: .personal, name: "Giangiorgio", messages: [Message(sender: myself, message: "Test", date: Date())],seenByOther: true))
}
