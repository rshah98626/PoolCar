//
//  Message.swift
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
