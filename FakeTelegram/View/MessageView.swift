//
//  MessageView.swift
//  FakeTelegram
//
//  Created by Giuseppe Francione on 15/11/23.
//

import SwiftUI

struct MessageView: View {
    var image:Image?
    var chatType:ChatTypeEnum
    var currentMessage:Message
    var isLastMessageInColumn:Bool
    var body: some View {
            HStack(alignment: .bottom) {
                if (currentMessage.sender == myself) {
                    Spacer()
                }
                if(currentMessage.sender != myself) {
                    if(image != nil){
                        image!.resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "plus").resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .clipShape(Circle())
                    }
                }
                    
                ContentMessageView(messageContent: currentMessage.message,
                                   isCurrentUser: currentMessage.sender == myself).clipShape(ChatBubbleShape(direction: currentMessage.sender == myself ? .right : .left))
                
                if(currentMessage.sender != myself){
                    Spacer()
                }
                
            }
        }
}

#Preview {
    MessageView(image:Image("dog_0001"),chatType: .personal,currentMessage: Message(sender: "myself", message: "Ascanio is a better name", date: Date()),isLastMessageInColumn: false)
}
