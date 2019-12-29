//
//  Ride.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct Ride: Hashable, Codable, Identifiable {
    // swiftlint:disable:next identifier_name
    var id = UUID()
    var origin: String
    var destination: String
}
