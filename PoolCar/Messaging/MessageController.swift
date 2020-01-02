//
//  MessageController.swift
//  PoolCar
//
//  Created by Rahul Shah on 1/2/20.
//  Copyright © 2020 RSInc. All rights reserved.
//

import Combine
import SwiftUI

class MessageController: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()

    @Published var messages = [
        Message(message: "Hello world", avatar: "A", color: .red),
        Message(message: "Hi", avatar: "B", color: .blue)
    ]

    func sendMessage(_ msg: Message) {
        messages.append(msg)
        didChange.send(())
    }
}
