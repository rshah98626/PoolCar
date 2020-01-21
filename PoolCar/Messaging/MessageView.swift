//
//  MessageView.swift
//  PoolCar
//
//  Created by Rahul Shah on 1/2/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    @State var composedMessage: String = ""
    @EnvironmentObject var messageController: MessageController
    @Binding var chatShowing: Bool

    var closeChatButton: some View {
        HStack {
            Button("Close Chat") { self.chatShowing.toggle() }
            Spacer()
        }
        .padding()
    }

    var body: some View {
        VStack {
            closeChatButton

            List {
                ForEach(messageController.messages, id: \.self) { msg in
                    MessageRow(msg: msg)
                }
            }

            HStack {
                TextField("Message...", text: $composedMessage)
                    .frame(minHeight: 30)
                    .cornerRadius(10)
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .frame(minHeight: 50).padding()
        }.keyboardResponsive()
    }

    // corresponding addition to DB
    func sendMessage() {
        messageController.sendMessage(Message(message: composedMessage, avatar: "C", color: .green, isMe: true))
        composedMessage = ""
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(chatShowing: .constant(true)).environmentObject(MessageController())
    }
}
