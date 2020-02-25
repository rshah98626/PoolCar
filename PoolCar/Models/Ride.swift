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
    //place holder
    var driverName: String = "billy"
    var origin: String
    var destination: String
    var startTime: Double?

    var latitudeOrigin: Double
    var longitudeOrigin: Double
    var latitudeDestination: Double
    var longitudeDestination: Double
    //place holders
    var price: Double = 25
    var space: Double = 4
}
