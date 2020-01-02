//
//  MessageView.swift
//  PoolCar
//
//  Created by Rahul Shah on 1/2/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import SwiftUI

struct Message: Hashable {
    var message: String
    var avatar: String
    var color: Color
    var isMe: Bool = false
}

struct MessageView: View {
    @State var composedMessage: String = ""
    @EnvironmentObject var messageController: MessageController

    var body: some View {
        VStack {
            List {
                ForEach(messageController.messages, id: \.self) { msg in
                    MessageRow(msg: msg)
                }
            }

            HStack {
                TextField("Message...", text: $composedMessage).frame(minHeight: 30)
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .frame(minHeight: 50).padding()
        }
    }

    func sendMessage() {
        messageController.sendMessage(Message(message: composedMessage, avatar: "C", color: .green, isMe: true))
        composedMessage = ""
    }
}

struct MessageRow: View {
    var msg: Message

    var body: some View {
        Group {
            if !msg.isMe {
                HStack {
                    Group {
                        Text(msg.avatar)
                        Text(msg.message)
                            .bold()
                            .padding(10)
                            .foregroundColor(Color.white)
                            .background(msg.color)
                            .cornerRadius(10)
                    }
                }
            } else {
                HStack {
                    Group {
                        Spacer()
                        Text(msg.message)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(msg.color)
                            .cornerRadius(10)
                        Text(msg.avatar)
                    }
                }
            }
        }

    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView().environmentObject(MessageController())
    }
}
