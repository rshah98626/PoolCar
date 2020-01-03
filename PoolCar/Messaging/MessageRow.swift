//
//  MessageRow.swift
//  PoolCar
//
//  Created by Rahul Shah on 1/2/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import SwiftUI

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
                        Spacer()
                    }
                }
                .padding(.leading)
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
                .padding(.trailing)
            }
        }

    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MessageRow(msg: Message(message: "Hello world", avatar: "A", color: .red))
            MessageRow(msg: Message(message: "Sent by user", avatar: "B", color: .green, isMe: true))
        }
    }
}
