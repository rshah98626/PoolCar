//
//  Ride.swift
//  PoolCar
//
//  Created by Rahul Shah on 12/25/19.
//  Copyright © 2019 RSInc. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Ride: Hashable, Codable, Identifiable {
    // swiftlint:disable:next identifier_name
    var id = UUID()
    var origin: String
    var destination: String

    var lattitudeOrigin: Double
    var longitudeOrigin: Double
    var lattitudeDestination: Double
    var longitudeDestination: Double

    var price: Double = 25
}
