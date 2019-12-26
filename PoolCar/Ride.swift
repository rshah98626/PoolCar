//
//  Ride.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI

struct Ride: Hashable, Codable, Identifiable {
    var id: Int
    var origin: String
    var destination: String
}
